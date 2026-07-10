CLASS zcl_cp01_ARR DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES:
      BEGIN OF ty_vuelo,
        aerolinea     TYPE c LENGTH 2,
        num_vuelo     TYPE n LENGTH 4,
        origen        TYPE c LENGTH 3,
        destino       TYPE c LENGTH 3,
        precio        TYPE p LENGTH 9 DECIMALS 2,
        plazas_libres TYPE i,
      END OF ty_vuelo,
      tt_vuelos TYPE STANDARD TABLE OF ty_vuelo WITH EMPTY KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_cp01_ARR IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " ===== DATOS DE PARTIDA =====
    DATA(lt_vuelos) = VALUE tt_vuelos(
      ( aerolinea = 'LH' num_vuelo = '0400' origen = 'FRA' destino = 'JFK' precio = '899.00'  plazas_libres = 15 )
      ( aerolinea = 'AA' num_vuelo = '0017' origen = 'JFK' destino = 'SFO' precio = '450.50'  plazas_libres = 0  )
      ( aerolinea = 'IB' num_vuelo = '3740' origen = 'MAD' destino = 'BCN' precio = '120.00'  plazas_libres = 42 )
      ( aerolinea = 'LH' num_vuelo = '0455' origen = 'FRA' destino = 'MAD' precio = '310.75'  plazas_libres = 8  )
      ( aerolinea = 'AA' num_vuelo = '0064' origen = 'SFO' destino = 'JFK' precio = '510.00'  plazas_libres = 3  )
      ( aerolinea = 'IB' num_vuelo = '3950' origen = 'BCN' destino = 'LHR' precio = '275.30'  plazas_libres = 0  )
      ( aerolinea = 'LH' num_vuelo = '2030' origen = 'MUC' destino = 'FRA' precio = '95.00'   plazas_libres = 60 )
      ( aerolinea = 'SQ' num_vuelo = '0026' origen = 'SIN' destino = 'FRA' precio = '1250.00' plazas_libres = 5  )
    ).

    " ===== TAREA 1.1: Clasificación por precio =====
    out->write( '===== TAREA 1.1: Clasificacion por precio =====' ).

    LOOP AT lt_vuelos INTO DATA(ls_vuelo).
      DATA(lv_categoria) = COND string(
        WHEN ls_vuelo-precio < 150                           THEN 'Económico'
        WHEN ls_vuelo-precio >= 150  AND ls_vuelo-precio <= 500  THEN 'Estándar'
        WHEN ls_vuelo-precio > 500   AND ls_vuelo-precio <= 1000 THEN 'Premium'
        WHEN ls_vuelo-precio > 1000                          THEN 'First Class' ).

      out->write( |{ ls_vuelo-aerolinea }-{ ls_vuelo-num_vuelo } | &&
                  |({ ls_vuelo-precio } €) -> { lv_categoria }| ).
    ENDLOOP.

    " ===== TAREA 1.2: Filtrado con operadores lógicos =====
    out->write( '' ).
    out->write( '===== TAREA 1.2: Vuelos filtrados (FRA, con plazas, <=1000€) =====' ).

    DATA(lt_filtrados) = VALUE tt_vuelos( ).

    LOOP AT lt_vuelos INTO ls_vuelo
      WHERE plazas_libres > 0
        AND ( origen = 'FRA' OR destino = 'FRA' )
        AND precio <= 1000.

      APPEND ls_vuelo TO lt_filtrados.
      out->write( |{ ls_vuelo-aerolinea }-{ ls_vuelo-num_vuelo } | &&
                  |{ ls_vuelo-origen } -> { ls_vuelo-destino } | &&
                  |({ ls_vuelo-precio } €, { ls_vuelo-plazas_libres } plazas)| ).
    ENDLOOP.

    " ===== TAREA 1.3: Transformación de cadenas =====
    out->write( '' ).
    out->write( '===== TAREA 1.3: Transformacion de cadenas =====' ).

    LOOP AT lt_filtrados INTO ls_vuelo.
      DATA(lv_codigo)    = |{ ls_vuelo-aerolinea }-{ ls_vuelo-num_vuelo }|.
      DATA(lv_dest_min)  = to_lower( ls_vuelo-destino ).
      DATA(lv_longitud)  = strlen( lv_codigo ).

      out->write( |{ lv_codigo } | && |{ lv_dest_min } | && |{ lv_longitud }| ).
    ENDLOOP.

    " ===== TAREA 1.4: Resumen con funciones numéricas =====
    out->write( '' ).
    out->write( '===== TAREA 1.4: Resumen numerico =====' ).

    DATA(lv_max) = REDUCE #( INIT m = lt_vuelos[ 1 ]-precio
                              FOR v IN lt_vuelos
                              NEXT m = COND #( WHEN v-precio > m THEN v-precio ELSE m ) ).

    DATA(lv_min) = REDUCE #( INIT m = lt_vuelos[ 1 ]-precio
                              FOR v IN lt_vuelos
                              NEXT m = COND #( WHEN v-precio < m THEN v-precio ELSE m ) ).

    DATA(lv_total_precio) = REDUCE #( INIT s = 0
                                       FOR v IN lt_vuelos
                                       NEXT s = s + v-precio ).

    DATA(lv_media) = round( val = lv_total_precio / lines( lt_vuelos ) dec = 2 ).

    DATA(lv_total_plazas) = REDUCE i( INIT s = 0
                                      FOR v IN lt_vuelos
                                      NEXT s = s + v-plazas_libres ).

    out->write( |Precio maximo: { lv_max } €| ).
    out->write( |Precio minimo: { lv_min } €| ).
    out->write( |Precio medio: { lv_media } €| ).
    out->write( |Total plazas libres: { lv_total_plazas }| ).

  ENDMETHOD.

ENDCLASS.
