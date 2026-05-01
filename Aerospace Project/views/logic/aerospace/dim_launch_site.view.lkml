include: "/views/base/aerospace/dim_launch_site.view.lkml"
#-------------------- VISTA: dim_launch_site (LOGIC) ---------------------#
# Propósito: Mapeo 1:1 con la tabla dim_launch_site de la capa dorada. Detalla dimensiones y medidas
# Source: dim_launch_site
# PK: site_id
#
# Dimensiones:
#   -   Site_ID, Site_Code, Site_Name, Country, City, Latitude, Longitude, Agency, Active
#------------------------------------------------------------------

view: +dim_launch_site {

  #------------------------------------------------------------------
  # Dimensions: Launch Site
  #------------------------------------------------------------------

  dimension: site_id {
    label: "Id. Zona"
    group_label: "Zona"
    group_item_label: "Id. "
    description: "ID de la Zona de Lanzamiento"
  }
  dimension: site_code {
    label: "Codigo de Zona"
    group_label: "Zona"
    description: "Codigo de la Zona de Lanzamiento"
  }
  dimension: site_name {
    label: "Desc. Zona"
    group_label: "Zona"
    group_item_label: "Desc. "
    description: "Nombre de la Zona de Lanzamiento"
  }
  dimension: country {
    label: "Pais"
    description: "Pais de Lanzamiento"
  }
  dimension: city {
    label: "Ciudad"
    description: "Ciudad de Lanzamiento"
  }
  dimension: latitude {
    label: "Latitud"
    description: "Latitud del Lanzamiento"
  }
  dimension: longitude {
    label: "Longitud"
    description: "Longitud del Lanzamiento"
  }
  dimension: agency {
    label: "Agencia"
    description: "Agencia del Lanzamiento"
  }
  dimension: active {
    label: "Activo"
    description: "Booleano si la mision esta en Activo"
  }


  #------------------------------------------------------------------
  # System measure
  #------------------------------------------------------------------
  measure: count {
    hidden: yes
  }
}
