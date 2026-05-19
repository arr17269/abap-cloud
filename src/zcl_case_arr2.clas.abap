CLASS zcl_case_arr2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CASE_ARR2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



    Data(lv_edad) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
        min = 1
        max = 100 )->get_next(  ).




*  case lv_edad.
*    when 12.
*    out->write( lv_edad ).
*    when 18.
*    out->write( lv_edad ).
*    when 45.
*    out->write( lv_edad ).
*    when others.
*    out->write( lv_edad ).
*  endcase.

*    out->write( 'fin de programa' ).

  if lv_edad BETWEEN 1 and 12.
            out->write( |Si la edad es de: { lv_edad } años, el descuento es de 5€| ).

    elseif
        lv_edad between 13 and 18.
            out->write( |Si la edad es de: { lv_edad } años, el descuento es de 10€| ).
     elseif
        lv_edad between 19 and 65.
            out->write( |Si la edad es de: { lv_edad } años, el descuento es de 20€| ).
     elseif
        lv_edad > 65.
            out->write( |si la edad es de: { lv_edad } años, el descuento es de 10€| ).
     else.
         out->write( 'exento de pago' ).

  endif.












  ENDMETHOD.
ENDCLASS.
