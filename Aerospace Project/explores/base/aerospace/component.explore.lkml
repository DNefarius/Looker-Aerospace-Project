include: "/views/logic/aerospace/dim_component.view.lkml"

#----------------------------------------------------------------------
# EXPLORE: component (base)
#
# Purpose: Explore base de dim_component para sugerencias de filtros
# Grain:   componente
#----------------------------------------------------------------------

explore: component {
  from:  dim_component
  label: "Componente"
  hidden: yes
}
