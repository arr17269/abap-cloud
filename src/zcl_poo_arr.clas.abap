CLASS zcl_poo_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.  "no lleva INTERFACES

data lv_nombre type string. "atributos
DATA lv_color  TYPE string. "atributos
data lv_size TYPE string VALUE 'mediano'.

METHODS: ladrar returning value(rv_accion) type string. "metodo
METHODS: lanzar_pelota RETURNING value(rv_accion) type string. "atributo
METHODS: saltar RETURNING VALUE(rv_accion) type string. "string.
METHODS: comer RETURNING VALUE(rv_accion) type string.
METHODS: subir RETURNING VALUE(rv_accion) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_poo_arr IMPLEMENTATION.

METHOD ladrar.
    rv_accion = |{ lv_nombre } dice: Guau guau |.
ENDMETHOD.

METHOD lanzar_pelota.
    rv_accion = |{ lv_nombre } corre a por la pelota|.
 ENDMETHOD.

 METHOD saltar.
    rv_accion = |{ lv_nombre } da saltos por el parque |.

ENDMETHOD.

  METHOD comer.
    rv_accion = |{ lv_nombre } come despacio |.
  ENDMETHOD.

  METHOD subir.
    rv_accion = | { lv_nombre } sube al coche |.
  ENDMETHOD.

ENDCLASS.
