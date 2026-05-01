# 🚀 Mission Telemetry Dashboard
### Aerospace Component Health Monitoring — End-to-End Data Project

![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)
![Looker](https://img.shields.io/badge/Looker-4285F4?style=flat&logo=looker&logoColor=white)
![Looker Studio](https://img.shields.io/badge/Looker_Studio-4285F4?style=flat&logo=google&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-336791?style=flat&logo=postgresql&logoColor=white)
![LookML](https://img.shields.io/badge/LookML-34A853?style=flat)

---

## Overview

End-to-end Business Intelligence project that models a **Structural Health Monitoring (SHM)** system for an unmanned space mission. The solution covers the full data pipeline: dimensional modeling in Snowflake, semantic layer definition in LookML, and executive dashboards in Looker Studio.

The dashboard provides real-time telemetry analysis across 12 spacecraft components over a 6-month mission lifecycle (Q1–Q2 2024), enabling three distinct user profiles to monitor component degradation, optimize maintenance costs, and detect anomalies before they become critical failures.

---

## Architecture

```
Synthetic Data (Python)
        │
        ▼
   Snowflake DWH
   ┌─────────────────────────────────┐
   │  Star Schema                    │
   │  ├── FACT_COMPONENT_TELEMETRY   │
   │  ├── DIM_DATE                   │
   │  ├── DIM_COMPONENT              │
   │  ├── DIM_MISSION_PHASE          │
   │  ├── DIM_EVENT_TYPE             │
   │  └── DIM_LAUNCH_SITE            │
   └─────────────────────────────────┘
        │
        ▼
   Looker (LookML)
   ├── Views (dimensions + measures)
   ├── Explore (joins + aggregate table)
   └── NDT — Week over Week
        │
        ▼
   Looker Studio
   ├── Page 1: Mission Overview
   ├── Page 2: Maintenance & Costs
   └── Page 3: Event Registry
```

---

## Dataset

| Parameter | Value |
|-----------|-------|
| Total rows | 2,299 |
| Date range | 2024-01-01 → 2024-06-30 |
| Components | 12 (engines, power, sensors, structure) |
| Mission phases | 7 (prelaunch → launch → LEO → HEO → reentry → recovery) |
| Agencies | 6 (NASA, ESA, ROSCOSMOS, JAXA, ISRO) |
| Event types | 4 (none, anomaly, failure, maintenance) |

The dataset was synthetically generated to simulate realistic telemetry patterns: orbital phases have sparser readings due to communication delays, launch and reentry concentrate the highest density of events per hour, and sensor values follow phase-appropriate distributions (e.g. temperature peaks at 850°C during reentry, radiation spikes in HEO).

---

## Dimensional Model

**Star schema** with one fact table and five dimension tables:

- **`FACT_COMPONENT_TELEMETRY`** — one row per sensor reading per component. Contains physical measurements (temperature, vibration, pressure, radiation, energy) plus health score and maintenance cost.
- **`DIM_DATE`** — full calendar dimension with year, quarter, month, week and weekend flag. `DATE_KEY` as integer `YYYYMMDD` following DW best practices.
- **`DIM_COMPONENT`** — 12 components with type, subsystem, manufacturer, nominal operating ranges and criticality level.
- **`DIM_MISSION_PHASE`** — 7 mission phases with radiation risk, thermal stress and chronological order for correct sorting.
- **`DIM_EVENT_TYPE`** — 11 event/severity combinations with `SEVERITY_ORDER` field to enable correct ordering in visualizations without additional CASE logic.
- **`DIM_LAUNCH_SITE`** — 6 launch sites with geolocation coordinates (latitude/longitude) enabling geographic map visualizations.

---

## LookML Semantic Layer

### Views
Each dimension and the fact table have a dedicated `.view.lkml` file defining:
- Typed dimensions with Spanish labels and descriptions
- Standard measures: `avg_health_score`, `total_maintenance_cost`, `failure_rate`, `count_failures`, `total_radiation`, `avg_temperature`, `total_energy`
- Advanced measures using exponential and logarithmic functions:

```lookml
# Thermal-Radiation Risk Index — multiplicative exponential model
# Models the combined effect of temperature and radiation on component degradation
measure: thermal_radiation_risk_index {
  type: number
  sql: ROUND(LEAST(100,
         AVG(
           (1 - EXP(-0.001 * GREATEST(${TABLE}.TEMPERATURE_C, 0)))
           * (1 - EXP(-0.008 * ${TABLE}.RADIATION_MSV))
           * 100
         )
       ), 2) ;;
  label: "Thermal-Radiation Risk Index (0-100)"
}

# Logarithmic Degradation Index
# Penalizes low health scores disproportionately using log scale
measure: degradation_index {
  type: number
  sql: ROUND(100 - (AVG(LOG(${TABLE}.HEALTH_SCORE + 1)) / LOG(101)) * 100, 2) ;;
  label: "Logarithmic Degradation Index (%)"
}
```

### Native Derived Table — Week over Week
Self-join NDT that calculates current week vs previous week for health score and maintenance cost, avoiding the CTE nesting issues that LAG() + OVER PARTITION generates in Looker:

```sql
SELECT current_week.*, prev_week.avg_health AS health_last_week, ...
FROM weekly_aggregation AS current_week
LEFT JOIN weekly_aggregation AS prev_week
  ON current_week.component_id = prev_week.component_id
  AND current_week.week_number = prev_week.week_number + 1
```

### Aggregate Table
Defined inside the main Explore, precalculates monthly summaries by `component_type`, `phase_name` and `quarter_name`. Looker automatically routes monthly/quarterly queries to this ~45-row table instead of scanning the full 2,299-row fact table (aggregate awareness).

```lookml
aggregate_table: monthly_telemetry_summary {
  materialization: {
    sql_trigger_value: SELECT CURRENT_DATE ;;
  }
  query: {
    dimensions: [dim_date.quarter_name, dim_date.month_name,
                 dim_component.component_type, dim_mission_phase.phase_name]
    measures:   [fact_component_telemetry.avg_health_score,
                 fact_component_telemetry.total_maintenance_cost,
                 fact_component_telemetry.count_failures,
                 fact_component_telemetry.total_radiation]
  }
}
```

---

## Dashboard — Looker Studio

Three pages, each designed for a specific user profile:

### Page 1 — Mission Overview
**Audience:** Mission Operations Director

Provides an immediate health status of the entire mission without requiring filters. Key metrics: average health score, total failures, failure rate, total maintenance cost, weekly cost trend (WoW), maximum temperature, total energy consumption and accumulated radiation. Supported by a structural integrity evolution line chart and an event type distribution donut chart.

### Page 2 — Maintenance & Costs
**Audience:** Maintenance Engineer

Operational analysis to understand failure causes and support decision-making. Includes: failures detected by component type, energy consumption by component, radiation by mission phase and total cost by mission phase. Radiation and temperature are placed prominently because environmental conditions must be understood before analyzing their consequences on costs and failures.

### Page 3 — Event Registry
**Audience:** Data Analyst / Auditor

Granular data access for incident investigation. Contains: TOP 5 components by accumulated cost, detailed event log filtered to non-nominal readings ordered by severity, phase analysis table, and a geolocation map of launch sites sized by maintenance cost.

---

## Key Insights from the Data

- **HEO is the most critical phase**: concentrates 45% of total maintenance cost and 90% of accumulated radiation dose
- **Propulsion components** (engines + tanks) account for ~60% of total maintenance expenditure despite representing only 4 of 12 components
- **Reentry generates the highest failure rate** per reading due to extreme thermal stress (peaks above 850°C)
- **Health score degrades progressively** through the mission with accelerated drops during launch and reentry — visible in the weekly trend chart
- **Energy consumption correlates with failure events**: components that register failures in the same period show 30-40% higher energy consumption

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Data Warehouse | Snowflake |
| Semantic Layer | Looker + LookML |
| Visualization | Looker Studio |
| Data Generation | Python (synthetic) |
| Version Control | Git / GitHub |

---

## Project Structure

```
aerospace-telemetry-looker/
│
├── sql/
│   ├── 01_dimensions.sql        # CREATE + INSERT for all dimension tables
│   ├── 02_fact_table.sql        # Fact table DDL with FK constraints
│   └── 03_inserts_fact.sql      # 2,299 rows of synthetic telemetry data
│
├── lookml/
│   ├── aerospace.model.lkml     # Connection, includes, explore + aggregate table
│   ├── views/
│   │   ├── fact_component_telemetry.view.lkml
│   │   ├── dim_date.view.lkml
│   │   ├── dim_component.view.lkml
│   │   ├── dim_mission_phase.view.lkml
│   │   ├── dim_event_type.view.lkml
│   │   ├── dim_launch_site.view.lkml
│   │   └── ndt_wow_health_score.view.lkml
│
├── dashboard/
│   └── screenshots/             # Dashboard page screenshots (PDF)
│
└── README.md
```

---

## What I Learned

- Designing a **star schema** for time-series telemetry data and the trade-offs between star and snowflake schemas
- Building a **semantic layer in LookML**: views, explores, joins, derived tables and aggregate tables
- Implementing **Week over Week analysis** via self-join NDT to avoid Looker's CTE nesting limitations with window functions
- Using **exponential and logarithmic functions** in LookML measures to model non-linear physical phenomena (thermal degradation, radiation damage)
- Connecting Snowflake to Looker Studio and designing dashboards for multiple user profiles with different analytical needs
- Understanding **aggregate awareness** and how Looker automatically routes queries to precalculated tables

---

*Project developed as part of a Business Intelligence course. Data is synthetically generated and does not represent any real space agency or mission.*
