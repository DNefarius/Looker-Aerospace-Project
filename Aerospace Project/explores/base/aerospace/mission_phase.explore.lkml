include: "/views/logic/aerospace/dim_mission_phase.view.lkml"

#----------------------------------------------------------------------
# EXPLORE: mission_phase (base)
#
# Purpose: Explore base de dim_mission_phase para sugerencias de filtros
# Grain:   Fase de Mision
#----------------------------------------------------------------------

explore: mission_phase {
  from:  dim_mission_phase
  label: "Fase de Mision"
  hidden: yes
}
