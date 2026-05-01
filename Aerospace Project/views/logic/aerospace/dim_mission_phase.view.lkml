include: "/views/base/aerospace/dim_mission_phase.view.lkml"
#------------------ VISTA: dim_mission_phase (LOGIC) -------------------#
# Propósito: Mapeo 1:1 con la tabla dim_mission_phase de la capa dorada. Detalla dimensiones y medidas
# Source: dim_mission_phase
# PK: phase_id
#
# Dimensiones:
#   -   Phase_ID, Phase_Code, Phase_Name, Description, Typical_Duration_H, Phase_Order, Radiation_Risk, Thermal_Stress
#------------------------------------------------------------------

view: +dim_mission_phase {

  #------------------------------------------------------------------
  # Dimensions: Mission Phase
  #------------------------------------------------------------------

  dimension: phase_id {
    label: "Id. Fase"
    group_label: "Fase"
    group_item_label: "Id. "
    description: "ID de la Fase de Mision"
  }
  dimension: phase_code {
    label: "Codigo de Fase"
    group_label: "Fase"
    description: "Codigo de la Fase de Mision"
  }
  dimension: phase_name {
    label: "Desc. Fase"
    group_label: "Fase"
    group_item_label: "Desc. "
    description: "Descripcion/Nombre de la Fase de Mision"
  }
  dimension: description {
    label: "Descripcion"
    description: "Descripcion de la Fase de Mision"
  }
  dimension: typical_duration_h {
    label: "Duracion Tipica"
    description: "Duracion Tipica en Horas"
  }
  dimension: phase_order {
    label: "Orden de Fase"
    group_label: "Fase"
    description: "Orden de Fase de Mision"
  }
  dimension: radiation_risk {
    label: "Riesgo de Radiacion"
    description: "Riesgo de Radiacion de la Fase de Mision"
  }
  dimension: thermal_stress {
    label: "Estres Termico"
    description: "Estres Termico de la Fase de Mision"
  }


  #------------------------------------------------------------------
  # System measure
  #------------------------------------------------------------------
  measure: count {
    hidden: yes
  }
}
