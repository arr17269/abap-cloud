CLASS zcl_rangos_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rangos_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  sign-> dice si la condicion es incluir (I) o excluir (E)
*  I = lo quiero
*  E = no lo quiero
*  option -> dice el tipo de comparacion
*  EQ = igual a
*  NE = diferente a
*  GT = mayor que
*  LT = menor que
*  BT = entre
*  CP = patron ( como un "like" )
*  low = el valor minimo o valor exacto
*  high = el valor maximo (solo se usa con un "entre")
*
*  imaginar unan lista de coches y quieres los rojos y tambien los azules pero NO los amarillos

*  sing      option          low     high
*  i            eq          rojo
*  i            eq          azul
*  E            eq          amarillo
*

data lr_asientos TYPE RANGE OF /dmo/plane_seats_occupied."esto es una tabla interna copiada de una dmo
*out->write( lr_asientos ).

APPEND VALUE #( sign = 'I' option = 'BT' low = 50  high = 100 ) to lr_asientos. "vuelos entre 50 y 150 asientos
APPEND VALUE #( sign = 'I' option = 'EQ' low = 141 ) to lr_asientos. "vuelos igual a 150 asientos
APPEND VALUE #( sign = 'E' option = 'LT' low = 10 ) to lr_asientos. "NO QUIERO VUELOS CON MENOS DE 10 ASIENTOS

data lt_vuelos type table of /dmo/flight.
SELECT * from /dmo/flight
where seats_occupied in @lr_asientos
into table @lt_vuelos.

LOOP AT lt_vuelos into DATA(ls_vuelos).

out->write( ls_vuelos ).

*out->write( ls_vuelos-seats_occupied ).
if ls_vuelos-carrier_id = 'UA'.
out->write( ls_vuelos-carrier_id ).
ENDIF.



ENDLOOP.


*out->write( lr_asientos ).

  ENDMETHOD.
ENDCLASS.
