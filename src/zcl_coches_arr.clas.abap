CLASS zcl_coches_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_coches_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  data(lo_coche) = new zcl_fabrica_arr( ).
  data(lo_moto) = new zcl_fabrica_arr( ).
  data(lo_perro2) = new zcl_poo_arr( ).

   if lo_coche is bound.
    lo_coche->lv_color = 'rojo'.
    lo_coche->lv_puertas = 'tiene 4 puertas'.


    out->write( lo_coche->luz( ) ).
    out->write( lo_coche->parar( ) ).


    ENDIF.

 if lo_perro2 is bound.

    lo_perro2->lv_nombre = 'Risitas'.
    lo_perro2->lv_size = 'grande'.

    out->write( | { lo_perro2->subir( ) } | ).

   ENDIF.






  ENDMETHOD.
ENDCLASS.
