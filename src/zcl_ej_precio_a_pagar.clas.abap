CLASS zcl_ej_precio_a_pagar DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ej_precio_a_pagar IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

"calcular el precio de la entrada segun la edad del usuario.


  DATA lv_edad type i.
  DATA lv_precio type i VALUE 10.           "el orden importa. Primero las declaraciones, despues el Random.


  lv_edad = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                       min = 0
                                                     max = 100 )->get_next(  ).

 " OJO se pone la variable edad.

  IF lv_edad between 0 and 3.

    out->write( lv_edad ).
    out->write( |Entrada gratuita | ).

    elseif lv_edad between 4 and 18.

     out->write( lv_edad ).
     out->write( |La entrada cuesta 5€ | ).

    elseif lv_edad between 19 and 65.

      out->write( lv_edad ).
      out->write( |La entrada cuesta 10€ | ).

    else.

     out->write( lv_edad ).
     out->write( |Precio especial 3€ | ).

  ENDIF.











  ENDMETHOD.
ENDCLASS.
