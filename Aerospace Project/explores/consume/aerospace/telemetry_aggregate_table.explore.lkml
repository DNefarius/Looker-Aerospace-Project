include: "/explores/logic/aerospace/telemetry.explore.lkml"
#---------------------------------------------------------
# Explore from Telemetry for Aggregate Table
# Place in `Alumno26` model
#
# Columns:
#   - Dimensions: Component_Type, Month_Name, Quarter_Name, Phase_Name
#   - Measures: Avg_Health_Score, Avg_Temperature, Count_Failures, Total_Cost, Total_Radiation
#---------------------------------------------------------

explore: +telemetry {
  aggregate_table: rollup__dim_component_component_type__dim_date_month_name__dim_date_quarter_name__dim_mission_phase_phase_name {
    query: {
      dimensions: [dim_component.component_type, dim_date.month_name, dim_date.quarter_name, dim_mission_phase.phase_name]
      measures: [fact_component_telemetry.avg_health_score, fact_component_telemetry.avg_temperature, fact_component_telemetry.count_failures, fact_component_telemetry.total_cost, fact_component_telemetry.total_radiation]
    }

    materialization: {
      datagroup_trigger: ALUMNO_26
    }
  }
}
