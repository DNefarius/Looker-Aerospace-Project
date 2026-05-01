include: "/views/logic/aerospace/dim_launch_site.view.lkml"

#----------------------------------------------------------------------
# EXPLORE: launch_site (base)
#
# Purpose: Explore base de dim_launch_site para sugerencias de filtros
# Grain:   Zona de Lanzamiento
#----------------------------------------------------------------------

explore: launch_site {
  from:  dim_launch_site
  label: "Zona de Lanzamiento"
  hidden: yes
}
