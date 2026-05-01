include: "/views/logic/aerospace/dim_event_type.view.lkml"

#----------------------------------------------------------------------
# EXPLORE: event_type (base)
#
# Purpose: Explore base de dim_event_type para sugerencias de filtros
# Grain:   evento
#----------------------------------------------------------------------

explore: event_type {
  from:  dim_event_type
  label: "Tipo de Evento"
  hidden: yes
}
