CLASS zcl_if_arr2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_IF_ARR2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA lv_name type string value 'Daniel'.

     if lv_name = 'Daniel'.

            out->write( 'Hola Daniel' ).
     endif.

            out->write( 'el programa ha terminado' ).




  ENDMETHOD.
ENDCLASS.
