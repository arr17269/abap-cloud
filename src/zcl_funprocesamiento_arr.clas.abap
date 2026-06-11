CLASS zcl_funprocesamiento_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_funprocesamiento_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA lv_var TYPE string VALUE 'Hola, este es el curso de ABAP'.

  data lv_num type i VALUE 5.
  data lv_num1 type i VALUE 10.
  data lv_resultado TYPE i.



        out->write( | { lv_var } mayusculas - > { to_upper( lv_var ) } | ). "to_lower pasa a minusculas.
        "to_upper transforma a mayusculas.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "reverso
  out->write( | { lv_var } shift_let -> { shift_left( val = lv_var places = 5 ) } |   )."elimina los 5 caracteres primeros

 """""""""""""""""""""""""""""""""

  "funciones de contenido
  data: lv_text type string,
        lv_pattern type string.

        lv_text = ' the employees number is: 123-456-7890'.
        lv_pattern = `\d{3}-\d{3}-\d{4}`.

   data(lv_number) = match( val = lv_text pcre = lv_pattern occ = 1 ).



  ENDMETHOD.
ENDCLASS.
