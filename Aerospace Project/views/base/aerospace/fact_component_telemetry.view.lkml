#-------------- VISTA: fact_component_telemetry (BASE) ---------------#
# Propósito: Mapeo 1:1 con la tabla fact_component_telemetry de la capa dorada. Expone dimensiones sin procesar
# Source: fact_component_telemetry
# PK: reading_id
# FK: Date_key, Component_ID, Phase_ID, Event_Type_ID, Site_ID
#
# Dimensiones:
#   -   Reading_ID, Date_key, Component_ID, Phase_ID, Event_Type_ID, Site_ID, Reading_Timestamp, Temperature_C, Vibration_HZ, Pressure_Bar, Radiation_MSV, Energy_KWH, Health_Score, Maintenance_Cost_EUR)
#------------------------------------------------------------------

view: fact_component_telemetry {
  sql_table_name: @{db_schema}."FACT_COMPONENT_TELEMETRY" ;;

  #------------------------------------------------------------------
  # Dimensions: FACT Telemetry
  #------------------------------------------------------------------

  dimension: reading_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."READING_ID" ;;
  }
  dimension: date_key {
    type: date
    sql: ${TABLE}."DATE_KEY" ;;
  }
  dimension: component_id {
    type: number
    sql: ${TABLE}."COMPONENT_ID" ;;
  }
  dimension: phase_id {
    type: number
    sql: ${TABLE}."PHASE_ID" ;;
  }
  dimension: event_type_id {
    type: number
    sql: ${TABLE}."EVENT_TYPE_ID" ;;
  }
  dimension: site_id {
    type: number
    sql: ${TABLE}."SITE_ID" ;;
  }
  dimension: reading_timestamp {
    type: date_hour
    sql: ${TABLE}."READING_TIMESTAMP" ;;
  }
  dimension: temperature_c {
    type: number
    sql: ${TABLE}."TEMPERATURE_C" ;;
    value_format_name: decimal_1
  }
  dimension: vibration_hz {
    type: number
    sql: ${TABLE}."VIBRATION_HZ" ;;
    value_format_name: decimal_2
  }
  dimension: pressure_bar {
    type: number
    sql: ${TABLE}."PRESSURE_BAR" ;;
    value_format_name: decimal_2
  }
  dimension: radiation_msv {
    type: number
    sql: ${TABLE}."RADIATION_MSV" ;;
    value_format_name: decimal_3
  }
  dimension: energy_kwh {
    type: number
    sql: ${TABLE}."ENERGY_KWH" ;;
    value_format_name: decimal_2
  }
  dimension: health_score {
    type: number
    sql: ${TABLE}."HEALTH_SCORE" ;;
  }
  dimension: maintenance_cost_eur {
    type: number
    sql: ${TABLE}."MAINTENANCE_COST_EUR" ;;
    value_format_name: eur
  }


  #------------------------------------------------------------------
  # System measure
  #------------------------------------------------------------------
  measure: count {
    type: count
  }

}
