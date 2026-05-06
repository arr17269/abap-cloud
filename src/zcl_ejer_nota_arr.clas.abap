CLASS zcl_ejer_nota_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_ejer_nota_arr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    data lv_num TYPE i VALUE -2.

    IF lv_num >= 0 and lv_num <= 4.
                out->write( |la calificación es Suspenso { lv_num }| ).
        elseif lv_num >= 5 and lv_num <= 6.
                 out->write( |la calificación es Aprobado { lv_num }| ).
        elseif lv_num >= 7 and lv_num <= 8.
                out->write( |El resultado esperado es: Notable { lv_num }| ).
        elseif lv_num >= 9 and lv_num <= 10.
                out->write( |la calificación es Sobresaliente { lv_num }| ).
            else.
                out->write( |Error en la calificación, no puede ser inferior a 0 ni superior a 10| ).
   Endif.





  ENDMETHOD.

ENDCLASS.
