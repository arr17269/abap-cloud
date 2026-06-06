CLASS zcl_cohete_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cohete_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*
*  "cuenta atras para lanzamiento de un cohete.
*
* "a contar de 5 hasta 1, en 0 fuego.
*
* DATA lv_contador type i VALUE 5.
*
* "se puede declarar asi tambien (data(lv_contador) = 5. de forma lineal directa.
*
* while lv_contador > 0.
*
*    out->write( lv_contador ).
*
*    lv_contador = lv_contador - 1.          "esto es necesario para que no sea un bucle infinito.
*
*  ENDWHILE.
*
*    out->write( 'FUEGOOOO!!!' ).



 "----------------------------------------------------
    "CUENTA HACIA DELANTE HASTA 10
"-----------------------------------------------------

        DATA(lv_contador1) = 1.

        while lv_contador1 <= 10.

            out->write( lv_contador1 ).

            lv_contador1 = lv_contador1 + 1.
         ENDWHILE.

            out->write( 'YAAAA!!!' ).





  ENDMETHOD.
ENDCLASS.
