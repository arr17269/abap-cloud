CLASS zcl_fabrica_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

data lv_coche type string."despues de crear los atributos y los metodos hay que dar cerilla
DATA lv_moto  TYPE string.
DATA lv_color TYPE string.
data lv_puertas TYPE string.


METHODS: correr RETURNING VALUE(rv_accion) type string.
METHODS: frenar RETURNING VALUE(rv_accion) TYPE string.
METHODS: parar RETURNING VALUE(rv_accion) TYPE string.
METHODS: luz RETURNING VALUE(rv_accion) TYPE string.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fabrica_arr IMPLEMENTATION.


  METHOD correr.
        rv_accion = | { lv_coche } corre muy rapido |.
  ENDMETHOD.
  METHOD frenar.
        rv_accion = | { lv_coche } frena rapido |.
  ENDMETHOD.

  METHOD parar.
        rv_accion = | { lv_coche } para con suavidad |.
  ENDMETHOD.

  METHOD luz.
        rv_accion = | { lv_coche } enciende las luces |.
  ENDMETHOD.

ENDCLASS.
