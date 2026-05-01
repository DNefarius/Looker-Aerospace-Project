include: "/views/logic/aerospace/**.view.lkml"
include: "/pdts/aerospace/ndt_telemetry_lw.view.lkml"
include: "/explores/logic/aerospace/telemetry.explore.lkml"

#----------------------------------------------------------------------------------
# PIPELINE: Telemetry WoW
#
# Purpose: Calculo de medidas WoW mediante el merge datasets de TW y LW definidos sobre NDTs
# Flow: [telemetry] + [telemetry_lw]
#       --> [ndt_telemetry_wow_aux] (Joiner)
#       --> [ndt_telemetry_wow] (Persistence)
#       --> [telemetry_yoy] (Final User Explore)
# Grain: date_key, component_id, site_id, phase_id, event_type_id
#----------------------------------------------------------------------------------


# =================================================================================
# STEP 1: SEMANA ANTERIOR
#
# EXPLORE DE TELEMTRY PARA OBTENER EL PERIODO DE LA SEMANA ANTERIOR MEDIANTE EL CRUCE CON
# LA TABLA DIM_DATE A TRAVÉS DEL CAMPO fecha
# =================================================================================
explore: telemetry_lw {
  from: fact_component_telemetry
  hidden: yes

  # JOINS con dimensiones
  join: dim_date {
    type: inner
    relationship: many_to_one
    sql_on: ${telemetry_lw.date_key} = ${dim_date.fecha_lw} ;;
  }
  join: dim_component {
    type: inner
    relationship: many_to_one
    sql_on: ${telemetry_lw.component_id} = ${dim_component.component_id} ;;
  }
  join: dim_launch_site {
    type: inner
    relationship: many_to_one
    sql_on: ${telemetry_lw.site_id} = ${dim_launch_site.site_id} ;;
  }
  join: dim_mission_phase {
    type: inner
    relationship: many_to_one
    sql_on: ${telemetry_lw.phase_id} = ${dim_mission_phase.phase_id} ;;
  }
  join: dim_event_type {
    type: inner
    relationship: many_to_one
    sql_on: ${telemetry_lw.event_type_id} = ${dim_event_type.event_type_id} ;;
  }
}

# =================================================================================
# STEP 2: FULL OUTER JOIN
#
# SE FUSIONAN LAS CONSULTAS DE TW Y LW EN UNA UNICA CTE
# =================================================================================
explore: ndt_telemetry_wow_aux {
  from: ndt_telemetry_tw
  hidden: yes
  # Evitamos errores al tener medidas que mezclan campos de las tablas de dimension

  join: ndt_telemetry_lw {
    type: full_outer
    relationship: one_to_one
    sql_on: ${ndt_telemetry_wow_aux.date_key} = ${ndt_telemetry_lw.date_key}
          AND ${ndt_telemetry_wow_aux.component_id} = ${ndt_telemetry_lw.component_id}
          AND ${ndt_telemetry_wow_aux.site_id} = ${ndt_telemetry_lw.site_id}
          AND ${ndt_telemetry_wow_aux.phase_id} = ${ndt_telemetry_lw.phase_id}
          AND ${ndt_telemetry_wow_aux.event_type_id} = ${ndt_telemetry_lw.event_type_id} ;;
  }
}

# =================================================================================
# STEP 3: MATERIALIZACION
#
# SE GENERA UNA NUEVA TABLA DE HECHOS CON VALOR DE TW Y LW PARA
# CADA COMBINACIÓN DEL GRANO
# =================================================================================
explore: ndt_telemetry_wow {
  from: ndt_telemetry_wow_aux
  hidden: yes

}

# =================================================================================
# STEP 4: CONSUMO
#
# EXPLORE FINAL DE CONSUMO CON JOINS CON DIMENSIONES CORE
# =================================================================================
explore: telemetry_wow {
  from: ndt_telemetry_wow


# JOINS con dimensiones
  join: dim_date {
    type: inner
    relationship: many_to_one
    sql_on: ${telemetry_wow.date_key} = ${dim_date.date_key} ;;
  }
  join: dim_component {
    type: inner
    relationship: many_to_one
    sql_on: ${telemetry_wow.component_id} = ${dim_component.component_id} ;;
  }
  join: dim_launch_site {
    type: inner
    relationship: many_to_one
    sql_on: ${telemetry_wow.site_id} = ${dim_launch_site.site_id} ;;
  }
  join: dim_mission_phase {
    type: inner
    relationship: many_to_one
    sql_on: ${telemetry_wow.phase_id} = ${dim_mission_phase.phase_id} ;;
  }
  join: dim_event_type {
    type: inner
    relationship: many_to_one
    sql_on: ${telemetry_wow.event_type_id} = ${dim_event_type.event_type_id} ;;
  }
}
