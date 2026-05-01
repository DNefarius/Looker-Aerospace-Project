include: "/views/logic/aerospace/fact_component_telemetry.view.lkml"
include: "/explores/logic/aerospace/telemetry.explore.lkml"
#----------------------------------------------------------------------------------
# FILE: NDT TLEMETRY LW VIEWS
#
# Purpose: Define dos capas de NDTs para obtener la telemetria WoW por semana, mes, zona, componente, fase y evento.
#
# Pipeline:[{ndt_telemetry_tw}] + [{ndt_telemetry_lw}]
#   --> [{ndt_telemetry_wow_aux}] (Full Outer Join materialization)
#   --> [{ndt_telemetry_wow}] (Final persisted NDT)
#
# Grain: fecha, site_id, component_id, phase_id, event_type_id
#----------------------------------------------------------------------------------

# =================================================================================
# VIEW: ndt_telemetry_tw (STEP 1 -- Semana actual)
#
# GENERA LA CTE PARA SEMANA ACTUAL
# =================================================================================
view: ndt_telemetry_tw {
  extends: [fact_component_telemetry]
  derived_table: {
    explore_source: telemetry {
      column: date_key {}
      column: component_id {}
      column: site_id {}
      column: phase_id {}
      column: event_type_id {}
      column: cost {field: fact_component_telemetry.total_cost}
    }
  }
  measure: total_cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format_name: eur
  }
}

# =================================================================================
# VIEW: ndt_ventas_lw (STEP 2 -- Año Anterior)
#
# GENERA LA CTE PARA AÑO ANTERIOR
# =================================================================================
view: ndt_telemetry_lw {
  extends: [fact_component_telemetry]
  derived_table: {
    explore_source: telemetry_lw {
      column: date_key {field: dim_date.full_date}
      column: component_id {}
      column: site_id {}
      column: phase_id {}
      column: event_type_id {}
      column: cost_lw {field: telemetry_lw.total_cost}
    }
  }
  measure: total_cost_lw {
    type: sum
    sql: ${TABLE}.cost_lw ;;
    value_format_name: eur
  }
}

# =================================================================================
# VIEW: ndt_telemetry_wow_aux (STEP 3 -- FULL OUTER JOIN)
#
# JOIN ENTRE SEMANA ACTUAL Y ANTERIOR.
# SE REDEFINE EL GRANO PARA RESOLVER TW Y LW EN UNA FILA PARA CADA
# COMBINACION MEDIANTE COALESCE
# =================================================================================
view: ndt_telemetry_wow_aux {
  extends: [fact_component_telemetry]
  derived_table: {
    explore_source: ndt_telemetry_wow_aux {
      column: date_key_tw {field:ndt_telemetry_wow_aux.date_key}
      column: date_key_lw {field:ndt_telemetry_lw.date_key}
      column: component_id_tw {field:ndt_telemetry_wow_aux.component_id}
      column: component_id_lw {field:ndt_telemetry_lw.component_id}
      column: site_id_tw {field:ndt_telemetry_wow_aux.site_id}
      column: site_id_lw {field:ndt_telemetry_lw.site_id}
      column: phase_id_tw {field:ndt_telemetry_wow_aux.phase_id}
      column: phase_id_lw {field:ndt_telemetry_lw.phase_id}
      column: event_type_id_tw {field:ndt_telemetry_wow_aux.event_type_id}
      column: event_type_id_lw {field:ndt_telemetry_lw.event_type_id}
      column: cost {field:ndt_telemetry_wow_aux.total_cost}
      column: cost_lw {field:ndt_telemetry_lw.total_cost_lw}
    }
  }

  # ---------------------------------------------------------------
  # DIMENSIONES AUXILIARES RESULTANTES DEL FULL OUTER JOIN
  # ---------------------------------------------------------------
  dimension: date_key_tw {
    hidden: yes
  }
  dimension: date_key_lw {
    hidden: yes
  }
  dimension: component_id_tw {
    hidden: yes
  }
  dimension: component_id_lw {
    hidden: yes
  }
  dimension: site_id_tw {
    hidden: yes
  }
  dimension: site_id_lw {
    hidden: yes
  }
  dimension: phase_id_tw {
    hidden: yes
  }
  dimension: phase_id_lw {
    hidden: yes
  }
  dimension: event_type_id_tw {
    hidden: yes
  }
  dimension: event_type_id_lw {
    hidden: yes
  }
  dimension: maintenance_cost_eur {
    hidden: yes
  }
  dimension: cost_lw {
    hidden: yes
  }
  dimension: cost {
    hidden: yes
  }

  # ---------------------------------------------------------------
  # SE REDEFINE EL GRANO FINAL PARRA TENER UN UNICO VALOR
  # DE CADA HECHO POR CADA COMBINACIÓN UNICA DEL GRANO
  # ---------------------------------------------------------------
  dimension: date_key {
    sql: COALESCE(${date_key_tw}, ${date_key_lw}) ;;
  }
  dimension: component_id {
    sql: COALESCE(${component_id_tw}, ${component_id_lw}) ;;
  }
  dimension: site_id {
    sql: COALESCE(${site_id_tw}, ${site_id_lw}) ;;
  }
  dimension: phase_id {
    sql: COALESCE(${phase_id_tw}, ${phase_id_lw}) ;;
  }
  dimension: event_type_id {
    sql: COALESCE(${event_type_id_tw}, ${event_type_id_lw}) ;;
  }
}

# =================================================================================
# VIEW: ndt_telemetry_wow (STEP 4 -- MATERIALIZACION)
#
# MATERIALIZACION PARA REDUCIR COSTES DE CONSULTA Y MEJORAR PERFORMANCE
# =================================================================================
view: ndt_telemetry_wow {
  extends: [fact_component_telemetry]
  derived_table: {
    explore_source: ndt_telemetry_wow {
      column: date_key {}
      column: component_id {}
      column: site_id {}
      column: phase_id {}
      column: event_type_id {}
      column: cost {field: ndt_telemetry_wow.cost}
      column: cost_lw {field: ndt_telemetry_wow.cost_lw}
    }
    # cluster_keys: ["date_key", "component_id", "site_id", "phase_id", "event_type_id"]
  }

  # ---------------------------------------------------------------
  # SE EXPONEN LOS KPIS DE LW Y VARIACIONES PARA SU CONSUMO
  # ---------------------------------------------------------------
  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format_name: eur
  }
  measure: cost_lw {
    type: sum
    sql: ${TABLE}.cost_lw ;;
    value_format_name: eur
  }
  measure: cost_progression_wow {
    label: "% Progresion de Costes Semanal"
    description: "% Progresion Costes Semanal respecto Cost LW"
    type: number
    sql: ((${cost}-${cost_lw}) / NULLIF(${cost_lw}, 0)) ;;
  }
}
