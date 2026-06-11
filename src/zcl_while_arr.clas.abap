CLASS zcl_while_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WHILE_ARR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


DATA lv_num type i value 5.

data lv_domi type ZDE_DIRECCION_ARR value 'holaa'.
    while lv_num <= 10.

     "lv_num = lv_num + 1. La linea de abajo hace lo mismo que esta
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
