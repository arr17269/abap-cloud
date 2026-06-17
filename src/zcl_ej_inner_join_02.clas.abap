CLASS zcl_ej_inner_join_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ej_inner_join_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 1. Selección de datos uniendo 3 tablas, cálculo matemático en SELECT y filtros
    SELECT FROM /dmo/flight AS fli
      INNER JOIN /dmo/carrier AS car
        ON fli~carrier_id = car~carrier_id
      INNER JOIN /dmo/connection AS con
        ON fli~carrier_id      = con~carrier_id
       AND fli~connection_id   = con~connection_id
    FIELDS
      car~name AS carrier_name,
      fli~connection_id,
      con~airport_from_id,
      con~airport_to_id,
      fli~flight_date,
      fli~price,
      fli~currency_code,
      ( fli~seats_max - fli~seats_occupied ) AS seats_available
    WHERE fli~flight_date >= '20240101'
      AND fli~price        > 200
    ORDER BY fli~flight_date ASCENDING
    INTO TABLE @DATA(lt_informe_vuelos).


    " 2. Mostrar los resultados en la consola de Eclipse ADT
    IF sy-subrc = 0.
      out->write( '--- INFORME DE VUELOS DISPONIBLES (Desde 2024 y > 200) ---' ).
      out->write( lt_informe_vuelos ).
    ELSE.
      out->write( 'No se encontraron vuelos que cumplan con los criterios especificados.' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
