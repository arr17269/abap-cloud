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



  OUT->WRITE( |TAREA 1 | ).
  out->write( 'crea un rango de tabla que seleccione vuelos de las compañias AA, LH, SQ' ).
  OUT->WRITE( |  | ).
  OUT->WRITE( |  | ).


"TAREA 1: vuelos cuyo ID sea: AA, LH, SQ

  data lr_id TYPE RANGE OF /dmo/carrier_id.   "lr_ la "r" significa rango.


      APPEND VALUE #( sign = 'I' option = 'EQ' low = 'AA' ) to lr_id.   "sing dice si incluye "I" o excluye "E"
      APPEND VALUE #( sign = 'I' option = 'EQ' low = 'LH' ) to lr_id.   "aqui dice incluye la opcion igual a "AA"
      APPEND VALUE #( sign = 'I' option = 'EQ' low = 'SQ' ) to lr_id.

   SELECT FROM /dmo/flight
      FIELDS carrier_id, connection_id, flight_date
      WHERE carrier_id IN @lr_id
      INTO TABLE @DATA(lt_id).

    SORT lt_id BY carrier_id flight_date ASCENDING.       "forma de ordenar varios campos

    " Mostramos el resultado real encontrado
    IF lt_id IS NOT INITIAL.
      out->write( lt_id ).
    ELSE.
      out->write( 'No se encontraron CARRIER_ID de ese rango.' ).
    ENDIF.


  OUT->WRITE( |  | ).
  OUT->WRITE( |TAREA 2 | ).
  out->write( 'CONEXIONES QUE EMPIECEN POR 1*' ).
  OUT->WRITE( |  | ).
  OUT->WRITE( |  | ).
 "TAREA 2: conexiones que empiecen por 1* (1000-1999)

  data lr_connection TYPE RANGE OF /dmo/connection_id.              "NUMC 4 (4 digitos)

  APPEND VALUE #( sign = 'I' option = 'BT' low = '1000' high = '1999' ) to lr_connection. "BT entre

   " EXPLICACIÓN EXPERTA: Buscamos en la tabla de conexiones de DMO usando el rango
    SELECT FROM /dmo/flight
      FIELDS carrier_id, connection_id, flight_date
      WHERE connection_id IN @lr_connection
      INTO TABLE @DATA(lt_conexiones).

    SORT lt_conexiones BY flight_date DESCENDING.

    " Mostramos el resultado real encontrado
    IF lt_conexiones IS NOT INITIAL.
      out->write( lt_conexiones ).
    ELSE.
      out->write( 'No se encontraron vuelos con ese ID.' ).
    ENDIF.


  OUT->WRITE( |  | ).
  OUT->WRITE( |TAREA 3 | ).
  out->write( 'RANGO DE FECHAS 1/1/2025 Y 30/6/2026' ).
  OUT->WRITE( |  | ).
  OUT->WRITE( |  | ).
   "TAREA 3: FECHAS ENTRE 1/1/2025 I 30/06/2026

  data lr_fecha  type RANGE OF /dmo/flight_date.                     "decimos copia los tipos de flight_date "DATS 8"

  APPEND VALUE #(  sign = 'I' option = 'BT' low = '20250101' high = '20260630' ) to lr_fecha.  "primero el AÑO, MES, DIA

    SELECT FROM /dmo/flight
      FIELDS carrier_id, connection_id, flight_date
      WHERE flight_date IN @lr_fecha
      INTO TABLE @DATA(lt_vuelos_por_fecha).

    SORT lt_vuelos_por_fecha BY carrier_id flight_date ASCENDING.

    IF lt_vuelos_por_fecha IS NOT INITIAL.
      out->write( lt_vuelos_por_fecha ).
    ELSE.
      out->write( 'No hay vuelos programados para las fechas indicadas.' ).
    ENDIF.


  OUT->WRITE( |  | ).
  OUT->WRITE( |TAREA 4 | ).
  out->write( 'EXCLUYE LA COMPAÑIA- CARRIER_ID UA' ).
  OUT->WRITE( |  | ).
  OUT->WRITE( |  | ).
  "TAREA 4: excluye la compañía cuyo CARRIER_ID ES "UA".

  DATA lr_excl TYPE RANGE OF /dmo/carrier_id.
  APPEND VALUE #( sign = 'E' option = 'EQ' low = 'UA' ) to lr_excl.

  SELECT FROM /dmo/flight
      FIELDS carrier_id, connection_id, flight_date
      WHERE carrier_id IN @lr_excl
      INTO TABLE @DATA(lt_vuelos_excl_ua).

    SORT lt_vuelos_excl_ua BY carrier_id flight_date ASCENDING.

    IF lt_vuelos_excl_ua IS NOT INITIAL.
      out->write( lt_vuelos_excl_ua ).
    ELSE.
      out->write( 'No se pudieron recuperar vuelos excluyendo UA.' ).
    ENDIF.


  OUT->WRITE( |  | ).
  OUT->WRITE( |TAREA 5| ).
  out->write( 'PRECIO > 100 Y <= 50' ).
  OUT->WRITE( |  | ).
  OUT->WRITE( |  | ).
"TAREA 5: crear rango cuyos precios de vuelos >100 y <= 50 (dos tramos en la misma tabla)

 data lr_prec type range of /dmo/flight_price.

    APPEND value #( sign = 'I' option = 'GT' low = '100' ) to lr_prec.  "TB mayor que
    APPEND value #( sign = 'I' option = 'LE' low = '50' ) to lr_prec.   "LT menor que

    SELECT FROM /dmo/flight
      FIELDS carrier_id, connection_id, flight_date, price
      WHERE price IN @lr_prec
      INTO TABLE @DATA(lt_precio).

    SORT lt_precio BY carrier_id price ASCENDING.

    IF lt_precio IS NOT INITIAL.
      out->write( lt_precio ).
    ELSE.
      out->write( 'No hay vuelos incluidos en ese rango de precio.' ).
    ENDIF.


  OUT->WRITE( |  | ).
  OUT->WRITE( |TAREA 6| ).
  out->write( 'CONSULTA QUE MUESTRE LOS PUNTOS 1, 3 y 5' ).
  OUT->WRITE( |  | ).
  OUT->WRITE( |  | ).
 "TARE 6: consulta combinada que refleje ptos 1,2,4 y que muestre total lineas.


  SELECT from /dmo/flight                                        "selecciona de la /dmo/flight los campos...
  FIELDS carrier_id, connection_id, flight_date, price          "nombres de los campos no de los elementos (mirar la BD)
                                                                 "cuando carrier_id cumpla con los datos de lr_vuelos.
  WHERE carrier_id    IN @lr_id
  and flight_date     IN @lr_fecha
  and price   IN @lr_prec
  into table @DATA(lt_flights).

  SORT lt_flights BY carrier_id price ASCENDING.
                               " introduce los datos en la tabla interna "flights"


  out->write( |Vuelos encontrados: { lines( lt_flights ) } | ).    "cuenta las lineas de la tabla interna
  out->write( lt_flights ).


  ENDMETHOD.
ENDCLASS.
