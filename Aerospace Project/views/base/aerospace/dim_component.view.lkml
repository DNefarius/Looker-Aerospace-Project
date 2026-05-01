#-------------------- VISTA: dim_component (BASE) ---------------------#
# Propósito: Mapeo 1:1 con la tabla dim_component de la capa dorada. Expone dimensiones sin procesar
# Source: dim_component
# PK: component_id
#
# Dimensiones:
#   -   Component_ID, Component_Name, Component_Type, Subsystem, Manufacturer, Nominal_Temp_Min_C, Nominal_Temp_Max_C, Nominal_Pressure_Bar, Criticality_Level
#------------------------------------------------------------------

view: dim_component {
  sql_table_name: @{db_schema}."DIM_COMPONENT" ;;

  #------------------------------------------------------------------
  # Dimensions: Component
  #------------------------------------------------------------------

  dimension: component_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."COMPONENT_ID" ;;
  }
  dimension: component_name {
    type: string
    sql: ${TABLE}."COMPONENT_NAME" ;;
  }
  dimension: component_type {
    type: string
    sql: ${TABLE}."COMPONENT_TYPE" ;;
  }
  dimension: subsystem {
    type: string
    sql: ${TABLE}."SUBSYSTEM" ;;
  }
  dimension: manufacturer {
    type: string
    sql: ${TABLE}."MANUFACTURER" ;;
  }
  dimension: nominal_temp_min_c {
    type: number
    sql: ${TABLE}."NOMINAL_TEMP_MIN_C" ;;
  }
  dimension: nominal_temp_max_c {
    type: number
    sql: ${TABLE}."NOMINAL_TEMP_MAX_C" ;;
  }
  dimension: nominal_pressure_bar {
    type: number
    sql: ${TABLE}."NOMINAL_PRESSURE_BAR" ;;
  }
  dimension: criticality_level {
    type: string
    sql: ${TABLE}."CRITICALITY_LEVEL" ;;
  }


  #------------------------------------------------------------------
  # System measure
  #------------------------------------------------------------------
  measure: count {
    type: count
  }
}
