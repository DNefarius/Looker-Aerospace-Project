include: "/views/logic/aerospace/**.view.lkml"

#----------------------------------------------------------------------
# EXPLORE: Telemetry (logic)
#
# Purpose: Explore basico del modelo de telemetria aeroespacial (fact_component_telemetry)
# Grain:   fecha, component_id, event_type_id, site_id, phase_id
#
# Note: Todos los joins se definen como INNER para garantizar la inregridad a traves de las dimensiones.
#----------------------------------------------------------------------

explore: telemetry {
  from:  fact_component_telemetry
  label: "Telemetria Aeroespacial"
  view_name: fact_component_telemetry


  # JOINS con dimension
  join: dim_date {
    type: inner
    relationship: many_to_one
    sql_on: ${fact_component_telemetry.date_key} = ${dim_date.date_key} ;;
  }
  join: dim_component {
    type: inner
    relationship: many_to_one
    sql_on: ${fact_component_telemetry.component_id} = ${dim_component.component_id} ;;
  }
  join: dim_event_type {
    type: inner
    relationship: many_to_one
    sql_on: ${fact_component_telemetry.event_type_id} = ${dim_event_type.event_type_id} ;;
  }
  join: dim_launch_site {
    type: inner
    relationship: many_to_one
    sql_on: ${fact_component_telemetry.site_id} = ${dim_launch_site.site_id} ;;
  }
  join: dim_mission_phase {
    type: inner
    relationship: many_to_one
    sql_on: ${fact_component_telemetry.phase_id} = ${dim_mission_phase.phase_id} ;;
  }

  # -----------------------------------------------------------------------
  # PRE-BUILT QUERY: query1
  # -----------------------------------------------------------------------
  # query: query1 {
    # label: "Coste por Componente"
    # description: "Consulta de Coste por Componente"
    # dimensions: [dim_component.component_name]
    # measures: [fact_component_telemetry.total_cost]
  # }

}
