CLASS zcl_while_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_while_arr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


DATA lv_num type i value 5.


    while lv_num <= 10.

     "lv_num = lv_num + 1. La liena de abajo hace lo mismo que esta
     "lv_num += 1.

     lv_num = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                       min = 1
                                                        max = 11 )->get_next(  ).

     out->write( lv_num ).

    endwhile.


out->write( 'fin de programa ' ).
out->write( 'fin de programa ' ).
out->write( 'fin de programa ' ).


  ENDMETHOD.

ENDCLASS.
