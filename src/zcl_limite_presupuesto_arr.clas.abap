CLASS zcl_limite_presupuesto_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_limite_presupuesto_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*El Enunciado del Ejercicio: "El límite del presupuesto"
*Imagina que tienes una pequeña tabla interna con los precios de varios artículos que quieres comprar (una mochila, unos cascos, un ratón...). Tienes un presupuesto máximo de 50 euros en tu cartera.
*
*Quieres ir sumando los precios de los artículos uno a uno en el orden en que aparecen, pero el bucle debe detenerse inmediatamente si ocurre alguna de estas dos cosas:
*
*Ya has revisado todos los artículos de la lista.
*
*El gasto total supera los 50 euros (¡porque te quedarías sin dinero!).


*Revisando artículo 1. Gasto acumulado: 15
*Revisando artículo 2. Gasto acumulado: 35
*Revisando artículo 3. Gasto acumulado: 47
*¡STOP! El siguiente artículo supera tu presupuesto de 50€
*Límite alcanzado. Pudiste comprar 3 artículos. Gasto final: 47€


types tt_mis_precios type table of i WITH EMPTY KEY.  "CREAMOS PRIMERO LOS TIPOS PARA QUE NO DE ERROR.

DATA(lt_precios) =  VALUE tt_mis_precios( ( 15 )  ( 20 ) ( 12 ) ( 18 ) ( 5 ) ).

DATA(lv_indice) = 1.
data(lv_gasto_total) = 0.
data(lv_total_items) = lines( lt_precios ).


WHILE lv_indice <= lv_total_items AND lv_gasto_total <= 50.

data(lv_precio_articulo) = lt_precios[ lv_indice ].   "nos muestra el precio segun el indice.

    IF lv_gasto_total + lv_precio_articulo > 50.

        out->write( |STOP!! El siguiente articulo supera el presupuesto de 50€| ).
        EXIT.
    ENDIF.

    lv_gasto_total = lv_gasto_total + lv_precio_articulo.

    out->write( |Revisando articulo { lv_indice }. Gasto acumulado { lv_gasto_total } | ).

    lv_indice = lv_indice + 1.

  ENDWHILE.

  out->write( | | ).
  data(lv_articulos_comprados) = lv_indice - 1.
  out->write( |Limite alcanzado. Pudiste comprar { lv_articulos_comprados } articulos. Gasto final { lv_gasto_total }€| ).













  ENDMETHOD.
ENDCLASS.
