#-------------------- VISTA: dim_event_type (BASE) ---------------------#
# Propósito: Mapeo 1:1 con la tabla dim_event_type de la capa dorada. Expone dimensiones sin procesar
# Source: dim_event_type
# PK: event_type_id
#
# Dimensiones:
#   -   Event_Type_ID, Event_Type, Event_Severity, Severity_Order, Requires_Action, Cost_Category, Description
#------------------------------------------------------------------

view: dim_event_type {
  sql_table_name: @{db_schema}."DIM_EVENT_TYPE" ;;

  #------------------------------------------------------------------
  # Dimensions: Event Type
  #------------------------------------------------------------------

  dimension: event_type_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."EVENT_TYPE_ID" ;;
  }
  dimension: event_type {
    type: string
    sql: ${TABLE}."EVENT_TYPE" ;;
  }
  dimension: event_severity {
    type: string
    sql: ${TABLE}."EVENT_SEVERITY" ;;
  }
  dimension: severity_order {
    type: number
    sql: ${TABLE}."SEVERITY_ORDER" ;;
  }
  dimension: requires_action {
    type: yesno
    sql: ${TABLE}."REQUIRES_ACTION" ;;
  }
  dimension: cost_category {
    type: string
    sql: ${TABLE}."COST_CATEGORY" ;;
  }
  dimension: description {
    type: string
    sql: ${TABLE}."DESCRIPTION" ;;
  }


  #------------------------------------------------------------------
  # System measure
  #------------------------------------------------------------------
  measure: count {
    type: count
  }
}
