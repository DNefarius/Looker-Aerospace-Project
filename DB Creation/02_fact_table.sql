-- ============================================================
-- 02_fact_table.sql  —  Tabla de hechos
-- Proyecto: Telemetría aeroespacial
-- Compatible con Snowflake
-- Ejecutar DESPUÉS de 01_dimensions.sql
-- ============================================================

CREATE OR REPLACE TABLE FACT_COMPONENT_TELEMETRY (
    READING_ID              INT             NOT NULL PRIMARY KEY,

    -- Claves foráneas a dimensiones
    DATE_KEY                INT             NOT NULL,  -- FK → DIM_DATE.DATE_KEY (YYYYMMDD)
    COMPONENT_ID            VARCHAR(20)     NOT NULL,  -- FK → DIM_COMPONENT
    PHASE_ID                VARCHAR(20)     NOT NULL,  -- FK → DIM_MISSION_PHASE
    EVENT_TYPE_ID           INT             NOT NULL,  -- FK → DIM_EVENT_TYPE
    SITE_ID                 INT,                       -- FK → DIM_LAUNCH_SITE (nullable)

    -- Timestamp completo (para series de tiempo precisas en Looker)
    READING_TIMESTAMP       TIMESTAMP_NTZ   NOT NULL,

    -- Mediciones de sensores
    TEMPERATURE_C           FLOAT           NOT NULL,
    VIBRATION_HZ            FLOAT           NOT NULL,
    PRESSURE_BAR            FLOAT           NOT NULL,
    RADIATION_MSV           FLOAT           NOT NULL,
    ENERGY_KWH              FLOAT           NOT NULL,
    HEALTH_SCORE            INT             NOT NULL,  -- 0 a 100

    -- Métrica de coste (0.0 cuando EVENT_TYPE_ID = 1)
    MAINTENANCE_COST_EUR    FLOAT           NOT NULL,

    CONSTRAINT fk_date      FOREIGN KEY (DATE_KEY)       REFERENCES DIM_DATE(DATE_KEY),
    CONSTRAINT fk_component FOREIGN KEY (COMPONENT_ID)   REFERENCES DIM_COMPONENT(COMPONENT_ID),
    CONSTRAINT fk_phase     FOREIGN KEY (PHASE_ID)       REFERENCES DIM_MISSION_PHASE(PHASE_ID),
    CONSTRAINT fk_event     FOREIGN KEY (EVENT_TYPE_ID)  REFERENCES DIM_EVENT_TYPE(EVENT_TYPE_ID),
    CONSTRAINT fk_site      FOREIGN KEY (SITE_ID)        REFERENCES DIM_LAUNCH_SITE(SITE_ID)
);
