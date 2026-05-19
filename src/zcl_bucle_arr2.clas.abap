CLASS zcl_bucle_arr2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BUCLE_ARR2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA lv_num type i VALUE 0.

*    do 5 times." se puede hacer a traves de una variable data lv_rep type i value 5.
*        out->write( lv_num )."va a escribir 5 veces 0.
*
*        lv_num = lv_num + 1."primero sale 0 y va sumando 1 (0,1,2,3,4).
*
*        if lv_num = 3.
*        exit.
*        endif.
*
*
*
*    enddo.

"""""""""""""""""""""""""""""""""""""""""""""""WHILE
WHILE lv_num < 10.

    lv_num += 1.
        out->write( lv_num ).

        if lv_num = 3.
        exit.
        endif.




ENDWHILE.

    out->write( 'fin de programa' ).












  ENDMETHOD.
ENDCLASS.
