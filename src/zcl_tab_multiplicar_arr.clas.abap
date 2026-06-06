CLASS zcl_tab_multiplicar_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tab_multiplicar_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "construye la tabla de multiplicar del 1 al 10.
  " tiene que salir 1 x 2 = 2


*
*  DATA lv_num type i.
*  data lv_num2 type i.
*  data lv_resultado TYPE i.
*         "lv_resultado es igual al producto.
*
*        lv_num = 1.
*        lv_num2 = 1.  "Abap Cloud empieza a contar desde el 0
*
*        out->write( | | ).
*        out->write( |Tabla del 1 | ).
*        out->write( | | ).
*
*  do 10 times.
*
*
*        lv_resultado = lv_num * lv_num2.
*        out->write( | { lv_num } x { lv_num2 WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 2 ALIGN = RIGHT } | ).
*
*        lv_num2 += 1.       "igual que decir lv_num = lv_num + 1
*
*  ENDDO.
*
*       out->write( | | ).
*       out->write( |Tabla del 2 | ).
*       out->write( | | ).
*
*        lv_num = 2.
*        lv_num2 = 1.
*
* do 10 times.
*
*        lv_resultado = lv_num * lv_num2.
*        out->write( | { lv_num } x { lv_num2  WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 2 ALIGN = RIGHT } | ).
*        lv_num2 += 1.
*
*
*  ENDDO.
*
*       out->write( | | ).
*       out->write( |Tabla del 3 | ).
*       out->write( | | ).
*
*        lv_num = 3.
*        lv_num2 = 1.
*
* do 10 times.
*
*        lv_resultado = lv_num * lv_num2.
*        out->write( | { lv_num } x { lv_num2 WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 2 ALIGN = RIGHT } | ).
*        lv_num2 += 1.
*
*  ENDDO.
*
*       out->write( | | ).
*       out->write( |Tabla del 4 | ).
*       out->write( | | ).
*
*        lv_num = 4.
*        lv_num2 = 1.
*
* do 10 times.
*
*        lv_resultado = lv_num * lv_num2.
*        out->write( | { lv_num } x { lv_num2 WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 2 ALIGN = RIGHT } | ).
*        lv_num2 += 1.
*
*  ENDDO.
*
*       out->write( | | ).
*       out->write( |Tabla del 5 | ).
*       out->write( | | ).
*
*        lv_num = 5.
*        lv_num2 = 1.
*
* do 10 times.
*
*        lv_resultado = lv_num * lv_num2.
*        out->write( | { lv_num } x { lv_num2 WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 2 ALIGN = RIGHT } | ).
*        lv_num2 += 1.
*
*  ENDDO.
*
*       out->write( | | ).
*       out->write( |Tabla del 6 | ).
*       out->write( | | ).
*
*        lv_num = 6.
*        lv_num2 = 1.
*
* do 10 times.
*
*        lv_resultado = lv_num * lv_num2.
*        out->write( | { lv_num } x { lv_num2 WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 2 ALIGN = RIGHT } | ).
*        lv_num2 += 1.
*
*  ENDDO.
*
*       out->write( | | ).
*       out->write( |Tabla del 7 | ).
*       out->write( | | ).
*
*        lv_num = 7.
*        lv_num2 = 1.
*
* do 10 times.
*
*        lv_resultado = lv_num * lv_num2.
*        out->write( | { lv_num } x { lv_num2 WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 2 ALIGN = RIGHT } | ).
*        lv_num2 += 1.
*
*  ENDDO.
*
*       out->write( | | ).
*       out->write( |Tabla del 8 | ).
*       out->write( | | ).
*
*        lv_num = 8.
*        lv_num2 = 1.
*
* do 10 times.
*
*        lv_resultado = lv_num * lv_num2.
*        out->write( | { lv_num } x { lv_num2 WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 2 ALIGN = RIGHT } | ).
*        lv_num2 += 1.
*
*  ENDDO.
*
*       out->write( | | ).
*       out->write( |Tabla del 9 | ).
*       out->write( | | ).
*
*        lv_num = 9.
*        lv_num2 = 1.
*
* do 10 times.
*
*        lv_resultado = lv_num * lv_num2.
*        out->write( | { lv_num } x { lv_num2 WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 2 ALIGN = RIGHT } | ).
*        lv_num2 += 1.
*
*  ENDDO.
*
*       out->write( | | ).
*       out->write( |Tabla del 10| ).
*       out->write( | | ).
*
*        lv_num = 10.
*        lv_num2 = 1.
*
* do 10 times.
*
*        lv_resultado = lv_num * lv_num2.
*        out->write( | { lv_num } x { lv_num2 WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 3 ALIGN = RIGHT } | ).
*        lv_num2 += 1.
*
*   ENDDO.




    "USANDO PARAMETROS PARA QUE EL USUARIO ESCOJA EL NUMERO A MULTIPLICAR.



    data lv_resultado  type i.

    data lv_num type i VALUE 24.

    DO 10 TIMES.

        lv_resultado = lv_num * sy-index.  "sy-index devuelve el numero de vuelta del DO

        out->write( | { lv_num } * { sy-index WIDTH = 2 ALIGN = RIGHT } = { lv_resultado WIDTH = 2 ALIGN = RIGHT } | ).


    ENDDO.




"     HACERLO CON RANDOM

*DATA lv_resultado TYPE I.
*data lv_num type i.
*
*lv_num = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
*                                                       min = 1
*                                                        max = 10 )->get_next(  ).
*DO 10 TIMES.
*
*        lv_resultado = lv_num * sy-index.
*
*        out->write( | { lv_num } * { sy-index WIDTH = 3 ALIGN = RIGHT } = { lv_resultado WIDTH = 3 ALIGN = RIGHT } | ).
*
*ENDDO.

  ENDMETHOD.
ENDCLASS.
