CLASS zcl_ej_do_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ej_do_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


  data lv_num type i value 0.


  do 5 times.

    out->write( lv_num ).
    lv_num = lv_num + 1.
        if lv_num = 3.
            exit.
        ENDIF.



  ENDDO.

     out->write( lv_num ).
     out->write( 'fin de programa' ).


  ENDMETHOD.
ENDCLASS.
