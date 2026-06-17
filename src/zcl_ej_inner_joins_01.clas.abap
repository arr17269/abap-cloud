CLASS zcl_ej_inner_joins_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ej_inner_joins_01 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 1. Selección de datos con INNER JOIN, filtros y ordenación
    SELECT FROM /dmo/carrier AS car
      INNER JOIN /dmo/connection AS con
        ON car~carrier_id = con~carrier_id
    FIELDS
      car~name AS carrier_name,
      con~connection_id,
      con~airport_from_id,
      con~airport_to_id,
      con~distance,
      con~distance_unit
    WHERE car~currency_code = 'EUR'
    ORDER BY carrier_name ASCENDING, con~connection_id ASCENDING
    INTO TABLE @DATA(lt_catalogo_rutas).


    " 2. Mostrar el resultado en la consola de ABAP (Eclipse ADT)
    IF sy-subrc = 0.
      out->write( '--- CATÁLOGO DE RUTAS AÉREAS (Moneda: EUR) ---' ).
      out->write( lt_catalogo_rutas ).
    ELSE.
      out->write( 'No se encontraron rutas con aerolíneas que operen en EUR.' ).
    ENDIF.







  ENDMETHOD.
ENDCLASS.
