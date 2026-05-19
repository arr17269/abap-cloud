CLASS zcl_ejer_tablas_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EJER_TABLAS_ARR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  TYPES:BEGIN OF TY_persona,
        nombre TYPE string,
        edad type i,
        telefono type string,
        email type string,
        direccion type string,
        pais type string,

        END OF TY_persona.

    data ls_cliente type ty_persona.
    data lt_cliente type TABLE OF ty_persona.


    """"""""""""""""""""""""""""""""""""""""""""""""""
*    introducir los datos de forma moderna.
    """"""""""""""""""""""""""""""""""""""""""""""""""

    lt_cliente = value #(
                    ( nombre = 'Ana'     edad = 24 telefono = '85897548'  email = 'alegria@yahoo.es'           direccion = 'C/Velazquez 12' pais = 'España' )
                    ( nombre = 'Lorenzo' edad = 30 telefono = '858975482' email = 'chollo@gmail.com'           direccion = 'C/Romeral 23'   pais = 'Francia' )
                    ( nombre = 'Maria'   edad = 50 telefono = '256958471' email = 'porquenotecallas@gmail.com' direccion = 'C/Angustias 2'  pais = 'Italia' )
                    ( nombre = 'Daniel'  edad = 35 telefono = '356987452' email = 'comentario@yahoo.es'        direccion = 'C/Esquina 24'   pais = 'Venezuela' )
                    ( nombre = 'Carmen'  edad = 25 telefono = '958236654' email = 'aprendizaje@Yahoo.es'       direccion = 'C/Nose 15'      pais = 'España' )
                       ).

           out->write( |Ejercicio 1. Crear tabla generando valores de forma moderna| ).

           out->write( | | ).
           out->write( lt_cliente ).

  """""""""""""""""""""""""""""""""""""""""""""
*  copiar tipos de tabla
  """"""""""""""""""""""""""""""""""""""""""""""

          out->write( | | ).
          out->write( |Ejercicio 2. Copiar tabla LIKE| ).

  data lt_cliente2 like lt_cliente.
         out->write( | | ).
         out->write( |TABLA 2| ).
         out->write( lt_cliente2 ).

*  INSERT LINES OF lt_cliente INTO TABLE lt_cliente2.


*        out->write( | | ).
*        out->write( |Ejercicio 2. CopiarTabla con APPEND| ).
*        out->write( | | ).
*        out->write( lt_cliente2 ).

*    """"""""""""""""""""""""""""""""""""""""""""""""""
*    "copiar tipos de tabla cliente directamente a otra tabla: cliente2.
*    """"""""""""""""""""""""""""""""""""""""""""""""""
*
*        out->write( | | ).
*        out->write( |Ejercicio 2. Copiar tabla con LIKE| ).
*
*    data lt_cliente2 like lt_cliente.
*
*    INSERT LINES OF lt_cliente INTO TABLE lt_cliente2.
*
*
*    APPEND value #(
*                   nombre = 'Pedro'
*                   edad = 36
*                   telefono = '125487563'
*                   email = 'oleole@gmail.com'
*                   direccion = 'C/Esperanza 5'
*                   pais = 'Alemania' ) to lt_cliente2.
*
*
*    out->write( lt_cliente2 ).
*
*
*
*
*
*

  ENDMETHOD.
ENDCLASS.
