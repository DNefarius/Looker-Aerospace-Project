include: "/views/base/aerospace/fact_component_telemetry.view.lkml"
#-------------- VISTA: fact_component_telemetry (LOGIC) ---------------#
# Propósito: Mapeo 1:1 con la tabla fact_component_telemetry de la capa dorada. Detalla dimensiones y medidas
# Source: fact_component_telemetry
# PK: reading_id
# FK: Date_key, Component_ID, Phase_ID, Event_Type_ID, Site_ID
#
# Dimensiones:
#   -   Reading_ID, Date_key, Component_ID, Phase_ID, Event_Type_ID, Site_ID, Reading_Timestamp, Temperature_C, Vibration_HZ, Pressure_Bar, Radiation_MSV, Energy_KWH, Health_Score, Maintenance_Cost_EUR)
#------------------------------------------------------------------

view: +fact_component_telemetry {

  #------------------------------------------------------------------
  # Dimensions: FACT Telemetry
  #------------------------------------------------------------------

  dimension: reading_id {
    label: "Id. Lectura"
    group_label: "Lectura"
    group_item_label: "Id. "
    description: "ID de Lectura de Telemetria"
  }
  dimension: date_key {
    label: "Id. Fecha"
    description: "ID de la Fecha"
    hidden: yes
  }
  dimension: component_id {
    label: "Id. Componente"
    description: "ID del Componente"
    hidden: yes
  }
  dimension: phase_id {
    label: "Id. Fase"
    description: "ID de la Fase de Mision"
    hidden: yes
  }
  dimension: event_type_id {
    label: "Id. Tipo Evento"
    description: "ID del Tipo de Evento"
    hidden: yes
  }
  dimension: site_id {
    label: "Id. Zona"
    description: "ID de la Zona de Lanzamiento"
    hidden: yes
  }
  dimension: reading_timestamp {
    label: "Fecha/Hora de Lectura"
    description: "Fecha/Hora de Lectura en formato YY-MM-DD HH:MM:SS"
    hidden: yes
  }
  dimension: temperature_c {
    label: "Temperatura"
    description: "Temperatura en ºC"
  }
  dimension: vibration_hz {
    label: "Vibracion"
    description: "Vibracion en Hz"
  }
  dimension: pressure_bar {
    label: "Presion"
    description: "Presion en Bar"
  }
  dimension: radiation_msv {
    label: "Radiacion"
    description: "Radiacion en mSv"
  }
  dimension: energy_kwh {
    label: "Energia"
    description: "Consumo Energetico en kWh"
  }
  dimension: health_score {
    label: "Marcador de Salud"
    description: "Marcador de Salud basado en la Lectura"
  }
  dimension: maintenance_cost_eur {
    label: "Coste de Mantenimiento"
    description: "Coste de Mantenimiento en Euros"
    hidden: yes
  }
  dimension: health_stamp {
    type: string
    label: "Nivel de Salud"
    description: "Nivel de Salud basado en el Marcador de Lectura"
    sql:
      CASE
        WHEN ${TABLE}.health_score>=80 THEN 'OPTIMO'
        WHEN ${TABLE}.health_score>=50 AND ${TABLE}.health_score<80 THEN 'ACEPTABLE'
        WHEN ${TABLE}.health_score>=30 AND ${TABLE}.health_score<50 THEN 'DETERIORADO'
        WHEN ${TABLE}.health_score<30 THEN 'CRITICO'
        END ;;
  }
  # dimension: fecha_lectura {
  #   label: "Fecha Lectura"
  #   description: "Formato de ID Fecha a tipo fecha"
  #   type: date
  #   hidden: yes
  #   sql: TO_DATE(${fecha_lectura}::VARCHAR,'YYYYMMDD') ;;
  # }


  #------------------------------------------------------------------
  # System measure
  #------------------------------------------------------------------
  measure: count {
    hidden: yes
  }
  measure: reading_count {
    type: count_distinct
    sql: ${reading_id} ;;
    label: "Contador de Lecturas"
  }
  measure: total_energy {
    type: sum
    sql: ${energy_kwh} ;;
    label: "Energia Consumida"
    description: "Energia Total Consumida en kWh"
  }
  measure: total_radiation {
    type: sum
    sql: ${radiation_msv} ;;
    label: "Radiacion Total"
    description: "Radiacion Total Acumulada en mSv"
  }
  measure: avg_temperature {
    type: average
    sql: ${temperature_c} ;;
    label: "Temperatura Media ºC"
    value_format_name: decimal_1
  }
  measure: total_cost {
    type: sum
    sql: ${maintenance_cost_eur} ;;
    label: "Coste Total"
    description: "Coste Total de Mantenimiento en Euros"
  }
  measure: total_cost_lw {
    label: "Coste Total LW"
    description: "Coste Total de Mantenimiento en el periodo Homologo"
    hidden: yes
    type: sum
    sql: ${maintenance_cost_eur} ;;
    value_format_name: eur
  }

  measure: avg_maintenance_cost {
    label: "Coste Medio"
    description: "Coste Medio de Mantenimiento en Euros"
    type: average
    filters: [event_type_id: "NOT 1"]
    sql: ${maintenance_cost_eur} ;;
    value_format_name: decimal_1
  }
  measure: avg_health_score {
    type: average
    label: "Media de Salud"
    description: "Media de la puntuacion de salud de la maquinaria"
    sql: ${health_score} ;;
    value_format_name: decimal_1
  }
  measure: count_events {
    type: count_distinct
    label: "Eventos Anómalos"
    description: "Eventos totales que requieren atención"
    sql: ${event_type_id} ;;
    filters: [event_type_id: "NOT 1"]
  }
  measure: count_maintenance {
    type: count_distinct
    label: "Eventos a Reparar"
    description: "Eventos totales que requieren Mantenimiento"
    sql: ${event_type_id} ;;
    filters: [event_type_id: "6, 7, 8"]
  }
  measure: count_failures {
    type: count_distinct
    label: "Eventos Criticos"
    description: "Eventos totales fallidos"
    sql: ${event_type_id} ;;
    filters: [event_type_id: "9, 10, 11"]
  }
  measure: failure_rate {
    type: number
    sql: ROUND(100*(${count_failures}/NULLIF(${count}, 0)), 2) ;;
    label: "% Tasa de Fallos"
    description: "% Tasa de Eventos Fallidos respecto a los Eventos Totales"
    value_format_name: decimal_2
  }

  # Los componentes no se degradan de forma lineal, es más peligroso cuanto más daño hayan acumulado, por lo que se define una medida que convierte en logaritmica la puntuación de Salud
  measure: degradation_index {
    type: number
    sql: ROUND(100-(AVG(LN(${health_score}+1))/
        LN(101))*100, 2) ;;
    label: "Indice de Degradacion (Log)"
    description: "Indice de Degradacion Logaritmico de los Componentes"
    value_format_name: decimal_2
  }

  # De la misma forma que la degradación, la salud no predice el comportamiento del componente, por lo que podemos usar la tasa de variación de Salud para comprobar que tiene más prob de fallo
  measure: health_volatility {
    type: number
    sql: ROUND(STDDEV(${health_score}), 2) ;;
    label: "Volatilidad de Salud"
    description: "Volatilidad de la puntuación de Salud basada en Desviación Típica"
    value_format_name: decimal_2
  }

  # Los costes dependen de cuantas lecturas se hayan realizado (duración de misión), pero la medida de costes totales no tiene esto en cuenta. Así que se define una medida que aporta el coste ponderado según lecturas
  measure: cost_per_reading {
    type: number
    label: "Coste por Lectura"
    description: "Coste ponderado segun el numero de Registros"
    sql: ROUND(${total_cost}/NULLIF(${count}, 0), 2) ;;
    value_format_name: eur
  }

  # La medida más compleja. El riesgo térmico y de radiación normalmente no se evalúan por separado, ya que el riesgo aumenta exponencialmente al juntar estas dos variables. Esta medida calcula la tasa de riesgo combinando ambas variables.
  # NOTA: Las medidas '1-exp' son medidas independientes que evaluan una tasa de riesgo exponencial entre 0 y 1, aquí se ha hecho para temperatura y para radiacion y se han multiplicado directamente (deberían haberse hecho medidas independientes, pero no iban a ser usadas). Los coeficientes 0.001 y 0.008 son coeficientes de normalización ajustados para que cuando los niveles empiecen a ser peligrosos el indicador pase de 0.5
  measure: thermal_radiation_risk {
    type: number
    sql: ROUND(LEAST(100,
            AVG((1-EXP(-0.001*GREATEST(${temperature_c}, 0)))*
                (1-EXP(-0.008*${radiation_msv}))*100)
              ), 2);;
    value_format_name: decimal_2
  }

}
