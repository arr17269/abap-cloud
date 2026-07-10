CLASS zcl_field_symbol DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_field_symbol IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  select from /dmo/flight

  fields *

  into table @data(lt_flight).

sort lt_flight by carrier_id.

LOOP AT lt_flight ASSIGNING FIELD-SYMBOL(<fs_flight>).

<fs_flight>-price = <fs_flight>-price * 2.

ENDLOOP.

"aqui apagamos el láser

UNASSIGN <fs_flight>.

  out->write( lt_flight ).





  ENDMETHOD.
ENDCLASS.
