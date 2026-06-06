CLASS zcl_objetos2_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.  "todos los atributos y metodos son publicos y accesibles.

    CLASS-DATA lv_moneda TYPE c LENGTH 3.        "si lleva (class delante) significa que es un atributo estatico
    DATA lv_region TYPE string.

    METHODS set_cliente                          "sale cruz roja porque hay que darle 2 clic y sale metodo solo abajo.

    importing iv_cliente type string
              iv_localizacion type string          "parametros de entrada.

    exporting ev_status type string             "parametros de salida

    changing cv_proceso type string.            "parametros de cambio


    METHODS get_cliente

        EXPORTING ev_cliente type string.


*    CLASS-METHODS:
*
*          set_cntr_type IMPORTING iv_cntr_type type string,            "declaraciones al mismo tiempo (class-methods:)
*
*           get_cntr_type EXPORTING ev_cntr_type type string.
*

    CLASS-METHODS set_cntr_type                                         "otra forma de hacerlo (una por una)
    IMPORTING iv_cntr_type type string.

    CLASS-METHODS get_cntr_type
    exporting ev_cntr_type type string.




  PROTECTED SECTION.    "es solo accesible para esta clase y las clases hijas

  data lv_fecha type sydate. "esto es una atributo de instancia

  PRIVATE SECTION.      "es accesible solo para esta clase y las clases friends

  data lv_cliente type string. "esto es un atributo de instancia


ENDCLASS.



CLASS zcl_objetos2_arr IMPLEMENTATION.















  METHOD set_cliente.
  lv_cliente = iv_cliente.
  ev_status = 'OK'.
  cv_proceso = 'started'.

  ENDMETHOD.


  METHOD get_cliente.
  ev_cliente = lv_cliente.

  ENDMETHOD.

  METHOD get_cntr_type.

  ENDMETHOD.

  METHOD set_cntr_type.

  ENDMETHOD.

ENDCLASS.
