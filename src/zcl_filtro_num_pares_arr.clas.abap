CLASS zcl_filtro_num_pares_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_filtro_num_pares_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
"---------------------------------------------------------
  "FILTRAR LOS Nº PARES DE UN LISTADO INDICANDO QUE ES PAR.
  "LOS Nº IMPARES NO SE MUESTRAN EN CONSOLA
"----------------------------------------------------------

 data(lv_num) = 1.   "se declara de forma lineal la variable lv_num.

 WHILE lv_num <= 20.

        lv_num = lv_num + 1.

     IF  lv_num MOD 2 = 0.          "MOD es un operador que muestra el resto de una division.
                                    "Si el resto es 0 el nº es PAR.
        out->write( |El numero { lv_num } es PAR| ).
     ENDIF.

 ENDWHILE.








  ENDMETHOD.
ENDCLASS.
