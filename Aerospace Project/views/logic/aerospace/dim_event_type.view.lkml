include: "/views/base/aerospace/dim_event_type.view.lkml"
#-------------------- VISTA: dim_event_type (LOGIC) ---------------------#
# Propósito: Mapeo 1:1 con la tabla dim_event_type de la capa dorada. Expone dimensiones sin procesar
# Source: dim_event_type
# PK: event_type_id
#
# Dimensiones:
#   -   Event_Type_ID, Event_Type, Event_Severity, Severity_Order, Requires_Action, Cost_Category, Description
#------------------------------------------------------------------

view: +dim_event_type {

  #------------------------------------------------------------------
  # Dimensions: Event Type
  #------------------------------------------------------------------

  dimension: event_type_id {
    label: "Id. Tipo Evento"
    group_label: "Tipo Evento"
    group_item_label: "Id. "
    description: "ID del Tipo de Evento"
  }
  dimension: event_type {
    label: "Desc. Tipo Evento"
    group_label: "Tipo Evento"
    group_item_label: "Desc. "
    description: "Descripcion del Tipo de Evento"
  }
  dimension: event_severity {
    label: "Severidad del Evento"
    group_label: "Evento"
    description: "Severidad del Evento"
  }
  dimension: severity_order {
    label: "Orden de Severidad"
    description: "Orden de la Severidad del Evento"
  }
  dimension: requires_action {
    label: "Accion Requerida"
    description: "Booleano si alguna Accion es Requerida"
  }
  dimension: cost_category {
    label: "Categoria del Coste"
    description: "Categoria del Coste del Evento"
  }
  dimension: description {
    label: "Description"
    description: "Descripcion del Evento ocurrido"
  }


  #------------------------------------------------------------------
  # System measure
  #------------------------------------------------------------------
  measure: count {
    hidden: yes
  }
}
