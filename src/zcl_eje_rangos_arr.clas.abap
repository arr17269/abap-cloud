CLASS zcl_eje_rangos_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_eje_rangos_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  out->write( 'crea un rango de tabla que seleccione vuelos de las compañias AA, LH, SQ' ).
  OUT->WRITE( |  | ).



"tarea 1
  data lr_vuelos TYPE RANGE OF /dmo/carrier_id.


  APPEND VALUE #( sign = 'I' option = 'EQ' low = 'AA' ) to lr_vuelos.
  APPEND VALUE #( sign = 'I' option = 'EQ' low = 'LH' ) to lr_vuelos.
  APPEND VALUE #( sign = 'I' option = 'EQ' low = 'SQ' ) to lr_vuelos.

  "tarea 2 FECHAS ENTRE 1/1/2025 I 30/06/2026
  DATA lr_fecha type range of /dmo/flight_date.

  APPEND VALUE #( sign = 'I' option = 'BT' low = '20250101' high = '20260630' ) to lr_fecha.

 "tarea 3  CONEXION QUE EMPIECE POR 1
DATA lr_conex type range of /dmo/connection_id.
    APPEND value #( sign = 'I' option = 'BT' low = '1000' high = '1999' ) to lr_conex.

"tarea 4  excluye los vuelos UA
DATA lr_excl type range of /dmo/carrier_id.
    APPEND value #( sign = 'E' option = 'EQ' low = 'UA' ) to lr_excl.

 data lt_vuelos type table of /dmo/flight.

"tarea 5 crear rango cuyos precios de vuelos >100 y <= 50 (dos tramos en la misma tabla)

 data lr_prec type range of /dmo/flight_price.

    APPEND value #( sign = 'I' option = 'GT' low = '100' ) to lr_prec.
    APPEND value #( sign = 'I' option = 'LT' low = '50' ) to lr_prec.

 "tarea 6 consulta combinada que refleje pto 1, 2 3 y muestre total lineas.



 SELECT * from /dmo/flight
  where CARRIER_ID in @lr_vuelos "cuando carrier_id cumpla con los datos de lr_vuelos.
   into table @lt_vuelos.



  ENDMETHOD.
ENDCLASS.
