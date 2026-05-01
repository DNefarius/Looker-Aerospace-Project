include: "/views/base/aerospace/dim_date.view.lkml"
#-------------------- VISTA: dim_date (LOGIC) ---------------------#
# Propósito: Mapeo 1:1 con la tabla dim_date de la capa dorada. Detalla dimensiones y medidas
# Source: dim_date
# PK: date_key
#
# Dimensiones:
#   - Date_key, Full_date, Year, Quarter, Quarter_name, Month, Month_name, Month_short, Week_of_year, Day_of_month, Day_of_week, Day_name, Is_weekend
#------------------------------------------------------------------

view: +dim_date {

  #------------------------------------------------------------------
  # Dimensions: Date
  #------------------------------------------------------------------

  dimension: date_key {
    label: "Id. Fecha"
    group_label: "Fecha"
    group_item_label: "Id. "
    description: "ID stamp de la fecha"
  }
  dimension: year {
    label: "Year"
    group_label: "Year"
    description: "Año"
  }
  dimension: quarter {
    label: "Quarter"
    group_label: "Quarter"
    group_item_label: "Numero de trimestre"
  }
  dimension: quarter_name {
    label: "Desc. Quarter"
    group_label: "Quarter"
    description: "Nombre de trimestre"
  }
  dimension: month {
    label: "Mes"
    group_label: "Mes"
    description: "Numero de Mes"
  }
  dimension: month_name {
    label: "Desc. Mes"
    group_label: "Mes"
    description: "Nombre del Mes"
  }
  dimension: month_short {
    label: "Short Mes"
    group_label: "Mes"
    description: "Nombre corto del Mes"
  }
  dimension: week_of_year {
    label: "Semana del Año"
    group_label: "Week"
    description: "Numero de Semana del Año"
  }
  dimension: day_of_month {
    label: "Dia del Mes"
    group_label: "Dia"
    description: "Numero del Dia del Mes"
  }
  dimension: day_of_week {
    label: "Dia de Semana"
    group_label: "Dia"
    description: "Numero del Dia Semanal"
  }
  dimension: day_name {
    label: "Desc. Dia Semanal"
    group_label: "Dia"
    description: "Nombre del Dia de la Semana"
  }
  dimension: is_weekend {
    label: "Es Fin de Semana"
    group_label: "Semana"
    description: "Booleano si es Fin de Semana"
  }
  dimension: fecha_lw {
    label: "Fecha de la Semana Anterior"
    description: "Formato de ID Fecha a tipo fecha de Semana Anterior"
    type: date
    sql: DATEADD(week, -1, ${date_key}) ;;
  }
  dimension: full_date {
    label: "Desc. Fecha"
    group_label: "Fecha"
    group_item_label: "Desc. "
  }
  dimension_group: fecha {
  }

  #------------------------------------------------------------------
  # System Measure
  #------------------------------------------------------------------
  measure: count {
    hidden: yes
  }
}
