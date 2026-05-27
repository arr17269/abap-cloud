CLASS zcl_eje_select_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_eje_select_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  SELECT FROM /dmo/airport
  fields *
  where country = 'US'
  INTO TABLE @DATA(lt_aeropuerto).

  out->write( 'ejercicio 1. Filtro por country US' ).
  out->write( | | ).
  out->write( | | ).
  out->write( lt_aeropuerto ).


  SELECT FROM /dmo/airport
  fields *
  where name like 'L%'
  into table @data(lt_aeropuerto1).
  DATA lt_filtrado like lt_aeropuerto1.

  if sy-subrc = 0.

 loop AT lt_aeropuerto1 into data(ls_aeropuerto).

    if ls_aeropuerto-name+0(1) = 'L'.

    append ls_aeropuerto to lt_filtrado.

    endif.

 ENDLOOP.
ENDIF.

  out->write( |Ejercicio 2. Filtrar por Name que empiece por L | ).
  out->write( | | ).
  out->write( lt_filtrado ).







  ENDMETHOD.
ENDCLASS.
