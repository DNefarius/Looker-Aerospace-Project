#-------------------- VISTA: dim_date (BASE) ---------------------#
# Propósito: Mapeo 1:1 con la tabla dim_date de la capa dorada. Expone solo dimensiones
# Source: dim_date
# PK: date_key
#
# Dimensiones:
#   - Date_key, Full_date, Year, Quarter, Quarter_name, Month, Month_name, Month_short, Week_of_year, Day_of_month, Day_of_week, Day_name, Is_weekend
#------------------------------------------------------------------

view: dim_date {
  sql_table_name: @{db_schema}."DIM_DATE" ;;

  #------------------------------------------------------------------
  # Dimensions: Date
  #------------------------------------------------------------------

  # dimension: date_key {
  #   type: string
  #   sql: ${TABLE}."DATE_KEY" ;;
  # }
  dimension: date_key {
    primary_key: yes
    type: date
    sql: ${TABLE}."FULL_DATE" ;;
  }
  dimension: year {
    type: number
    sql: ${TABLE}."YEAR" ;;
  }
  dimension: quarter {
    type: number
    sql: ${TABLE}."QUARTER" ;;
  }
  dimension: quarter_name {
    type: string
    sql: ${TABLE}."QUARTER_NAME" ;;
  }
  dimension: month {
    type: number
    sql: ${TABLE}."MONTH" ;;
  }
  dimension: month_name {
    type: string
    sql: ${TABLE}."MONTH_NAME" ;;
  }
  dimension: month_short {
    type: string
    sql: ${TABLE}."MONTH_SHORT" ;;
  }
  dimension: week_of_year {
    type: number
    sql: ${TABLE}."WEEK_OF_YEAR" ;;
  }
  dimension: day_of_month {
    type: number
    sql: ${TABLE}."DAY_OF_MONTH" ;;
  }
  dimension: day_of_week {
    type: number
    sql: ${TABLE}."DAY_OF_WEEK" ;;
  }
  dimension: day_name {
    type: string
    sql: ${TABLE}."DAY_NAME" ;;
  }
  dimension: is_weekend {
    type: yesno
    sql: ${TABLE}."IS_WEEKEND" ;;
  }
  # dimension_group: fecha {
  #   type: time
  #   timeframes: [raw, date, week, month, quarter, year]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}."FULL_DATE" ;;
  # }

  #------------------------------------------------------------------
  # System Measure
  #------------------------------------------------------------------
  measure: count {
    type: count
    drill_fields: [month_name, day_name]
  }
}
