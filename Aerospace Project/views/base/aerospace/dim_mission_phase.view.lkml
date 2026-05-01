#-------------------- VISTA: dim_mission_phase (BASE) ---------------------#
# Propósito: Mapeo 1:1 con la tabla dim_mission_phase de la capa dorada. Expone dimensiones sin procesar
# Source: dim_mission_phase
# PK: phase_id
#
# Dimensiones:
#   -   Phase_ID, Phase_Code, Phase_Name, Description, Typical_Duration_H, Phase_Order, Radiation_Risk, Thermal_Stress
#------------------------------------------------------------------

view: dim_mission_phase {
  sql_table_name: @{db_schema}."DIM_MISSION_PHASE" ;;

  #------------------------------------------------------------------
  # Dimensions: Mission Phase
  #------------------------------------------------------------------

  dimension: phase_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."PHASE_ID" ;;
  }
  dimension: phase_code {
    type: string
    sql: ${TABLE}."PHASE_CODE" ;;
  }
  dimension: phase_name {
    type: string
    sql: ${TABLE}."PHASE_NAME" ;;
  }
  dimension: description {
    type: string
    sql: ${TABLE}."DESCRIPTION" ;;
  }
  dimension: typical_duration_h {
    type: number
    sql: ${TABLE}."TYPICAL_DURATION_H" ;;
  }
  dimension: phase_order {
    type: number
    sql: ${TABLE}."PHASE_ORDER" ;;
  }
  dimension: radiation_risk {
    type: string
    sql: ${TABLE}."RADIATION_RISK" ;;
  }
  dimension: thermal_stress {
    type: string
    sql: ${TABLE}."THERMAL_STRESS" ;;
  }


  #------------------------------------------------------------------
  # System measure
  #------------------------------------------------------------------
  measure: count {
    type: count
  }
}
