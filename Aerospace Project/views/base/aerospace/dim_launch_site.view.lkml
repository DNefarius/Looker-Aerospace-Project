#-------------------- VISTA: dim_launch_site (BASE) ---------------------#
# Propósito: Mapeo 1:1 con la tabla dim_launch_site de la capa dorada. Expone dimensiones sin procesar
# Source: dim_launch_site
# PK: site_id
#
# Dimensiones:
#   -   Site_ID, Site_Code, Site_Name, Country, City, Latitude, Longitude, Agency, Active
#------------------------------------------------------------------

view: dim_launch_site {
  sql_table_name: @{db_schema}."DIM_LAUNCH_SITE" ;;

  #------------------------------------------------------------------
  # Dimensions: Launch Site
  #------------------------------------------------------------------

  dimension: site_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."SITE_ID" ;;
  }
  dimension: site_code {
    type: string
    sql: ${TABLE}."SITE_CODE" ;;
  }
  dimension: site_name {
    type: string
    sql: ${TABLE}."SITE_NAME" ;;
  }
  dimension: country {
    type: string
    sql: ${TABLE}."COUNTRY" ;;
    tags: ["country"]
  }
  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }
  dimension: latitude {
    type: number
    sql: ${TABLE}."LATITUDE" ;;
    tags: ["latitude"]
  }
  dimension: longitude {
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
    tags: ["longitude"]
  }
  dimension: agency {
    type: string
    sql: ${TABLE}."AGENCY" ;;
  }
  dimension: active {
    type: yesno
    sql: ${TABLE}."ACTIVE" ;;
  }


  #------------------------------------------------------------------
  # System measure
  #------------------------------------------------------------------
  measure: count {
    type: count
  }
}
