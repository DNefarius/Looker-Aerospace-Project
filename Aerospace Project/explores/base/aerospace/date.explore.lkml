include: "/views/logic/aerospace/dim_date.view.lkml"

#----------------------------------------------------------------------
# EXPLORE: date (base)
#
# Purpose: Explore base de dim_date para sugerencias de filtros
# Grain:   fecha
#----------------------------------------------------------------------

explore: date {
  from:  dim_date
  label: "Calendario"
  hidden: yes
}
