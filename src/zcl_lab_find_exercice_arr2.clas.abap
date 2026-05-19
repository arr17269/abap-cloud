CLASS zcl_lab_find_exercice_arr2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_LAB_FIND_EXERCICE_ARR2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
"Eres un desarrollador en una empresa de logística.
"Tienes una cadena de texto que contiene un código de envío (ejemplo: SHIP-12345-ES).
"Tu tarea es verificar si la palabra "SHIP" existe en la cadena y determinar en qué posición comienza.

  DATA(lv_text) = |TRACKING_ID: SHIP-9988-ABC|."FIND cuenta los espacios y se empieza a contar desde 0|.
  DATA(lv_pattern) = |SHIP|.
  DATA lv_offset TYPE i.
  DATA(lv_text2) = 'ship: 955-ab'.
  find lv_pattern in lv_text MATCH OFFSET lv_offset. "si se quiere ignorar Mayus/Minus se pone INGNORING CASE MATCH OFFSET.
  find lv_pattern in lv_text2 IGNORING CASE MATCH OFFSET lv_offset.
  "sy-subrc = 0 , texto encontrado.
  "sy-subrc = 4, no hubo coincidencia


  if sy-subrc = 0.
    out->write( |El patron { lv_pattern } comienza en la posicion: { lv_offset } | ).
  else.                                                                                 "ELSE lleva punto al final.
    out->write( |No se encontro el patron solicitado.| ).
  ENDIF.


  ENDMETHOD.
ENDCLASS.
