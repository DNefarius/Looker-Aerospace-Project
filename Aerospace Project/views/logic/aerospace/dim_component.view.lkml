include: "/views/base/aerospace/dim_component.view.lkml"
#-------------------- VISTA: dim_component (LOGIC) ---------------------#
# Propósito: Mapeo 1:1 con la tabla dim_component de la capa dorada. Detalla dimensiones y medidas
# Source: dim_component
# PK: component_id
#
# Dimensiones:
#   -   Component_ID, Component_Name, Component_Type, Subsystem, Manufacturer, Nominal_Temp_Min_C, Nominal_Temp_Max_C, Nominal_Pressure_Bar, Criticality_Level
#------------------------------------------------------------------

view: +dim_component {

  #------------------------------------------------------------------
  # Dimensions: Component
  #------------------------------------------------------------------

  dimension: component_id {
    label: "Id. Componente"
    group_label: "Componente"
    group_item_label: "Id. "
    description: "ID del Componente"
  }
  dimension: component_name {
    label: "Desc. Componente"
    group_label: "Componente"
    group_item_label: "Desc. "
    description: "Descripcion/Nombre del Componente"
  }
  dimension: component_type {
    label: "Tipo Componente"
    group_label: "Componente"
    group_item_label: "Tipo "
    description: "Descripcion/Nombre del Tipo de Componente"
  }
  dimension: subsystem {
    label: "Subsistema"
    description: "Subsistema del Componente"
  }
  dimension: manufacturer {
    label: "Fabricante"
    description: "Fabricante del Componente"
  }
  dimension: nominal_temp_min_c {
    label: "Temperatura Nominal Min"
    description: "Temperatura Nominal Mínima en ºC"
  }
  dimension: nominal_temp_max_c {
    label: "Temperatura Nominal Max"
    description: "Temperatura Nominal Maxima en ºC"
  }
  dimension: nominal_pressure_bar {
    label: "Presión Nominal"
    description: "Presión Nominal en Bar"
  }
  dimension: criticality_level {
    label: "Nivel de Criticidad"
    description: "Nivel de Criticidad"
  }


  #------------------------------------------------------------------
  # System measure
  #------------------------------------------------------------------
  measure: count {
    hidden: yes
  }
}
