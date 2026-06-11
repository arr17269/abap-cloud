CLASS zcl_validacion_vuelo_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_validacion_vuelo_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  TYPES: BEGIN OF ty_vuelos,
         codigo_vuelo TYPE n LENGTH 4,
         num_pl_sol_cliente TYPE i,
         num_pl_ocupadas type i,
         num_pl_totales type i,
         num_pl_libres type i,
         tipo_cliente type string,
         END OF ty_vuelos.

   data lt_vuelos TYPE table of ty_vuelos.
   data ls_vuelos TYPE ty_vuelos.


   data(lv_pl_totales) = 40.
   data(lv_pl_ocupadas) = 0.
   DATA(lv_pl_libres) = lv_pl_totales.
   DATA(lv_solicitadas) = 5.
   DATA(lv_contador_vuelos) = 1.


   lt_vuelos = VALUE #(
            ( codigo_vuelo = 0 num_pl_sol_cliente = 2 tipo_cliente = 'NOT VIP' )
            ( codigo_vuelo = 2 num_pl_sol_cliente = -3 tipo_cliente = 'NOT VIP' )
            ( codigo_vuelo = 2 num_pl_sol_cliente = 5 tipo_cliente = 'VIP' )
                                            ).


    out->write( |--- PROCESANDO RESERVAS DEL AVION ---| ).
    out->write( | | ).

   LOOP AT lt_vuelos INTO ls_vuelos.

    DATA(lv_fila_actual) = sy-tabix.


"-------------------------------------------
"BLOQUE 1. REGLAS DE VALIDACION DE ENTRADA
"--------------------------------------------
   If ls_vuelos-codigo_vuelo IS INITIAL OR ls_vuelos-codigo_vuelo = 0.
    out->write( 'Error: el codigo de vuelo esta vacio' ).
    CONTINUE.

    elseif ls_vuelos-num_pl_sol_cliente <= 0.
    out->write( 'Error: las plazas solicitadas no pueden ser <= 0' ).
    CONTINUE.

    elseif lv_pl_ocupadas > lv_pl_totales.
    out->write( 'Error: Datos inconsistentes' ).
    CONTINUE.

    elseif ls_vuelos-num_pl_sol_cliente > lv_pl_libres.
    out->write( 'Reserva rechazada' ).
    CONTINUE.


    ENDIF.
"---------------------------------------------------------------
"BLOQUE 2. PROCESAMIENTO MATEMATICO (si los datos son correctos)
"----------------------------------------------------------------

         lv_pl_ocupadas = lv_pl_ocupadas + ls_vuelos-num_pl_sol_cliente.
         lv_pl_libres = lv_pl_totales - lv_pl_ocupadas.

        ls_vuelos-num_pl_totales  = lv_pl_totales.      "guardamos los calculos en la estructura
        ls_vuelos-num_pl_ocupadas = lv_pl_ocupadas.
        ls_vuelos-num_pl_libres  = lv_pl_libres.

     IF ls_vuelos-tipo_cliente = 'VIP'.
        out->write( |Vuelo { ls_vuelos-codigo_vuelo }: Reserva aceptada con prioridad VIP| ).
    else.
        out->write( |Vuelo: { ls_vuelos-codigo_vuelo } Reserva aceptada| ).
     ENDIF.

        MODIFY lt_vuelos FROM ls_vuelos INDEX lv_fila_actual. "para ingresar los datos en la tabla interna

        out->write( |Vuelo { ls_vuelos-codigo_vuelo }: Reserva ACEPTADA ({ ls_vuelos-num_pl_sol_cliente } pl.) -> Ocupadas: { lv_pl_ocupadas } | ).
        out->write( | Libres: { lv_pl_libres } de { lv_pl_totales } totales| ).

  ENDLOOP.
  "--------------------------------------------
  " BLOQUE 3. COMPLETAR EL AVION CON WHILE
  "--------------------------------------------

    WHILE lv_pl_libres > 0.

    CLEAR ls_vuelos.

        ls_vuelos-codigo_vuelo  = lv_contador_vuelos.
        ls_vuelos-num_pl_sol_cliente = lv_solicitadas.


     IF ls_vuelos-num_pl_sol_cliente <= lv_pl_libres.

        lv_pl_ocupadas = lv_pl_ocupadas + ls_vuelos-num_pl_sol_cliente. "hacemos los calculos
        lv_pl_libres   = lv_pl_totales - lv_pl_ocupadas.

        ls_vuelos-num_pl_totales  = lv_pl_totales.                      "guardamos los calculos en la estructura.
        ls_vuelos-num_pl_ocupadas = lv_pl_ocupadas.
        ls_vuelos-num_pl_libres = lv_pl_libres.
        ls_vuelos-tipo_cliente  = 'ACEPTADO'.


         APPEND ls_vuelos TO lt_vuelos.
       out->write( |Codigo { ls_vuelos-codigo_vuelo }: Aceptado ({ lv_solicitadas } pl.) -> Quedan { lv_pl_libres } libres.| ).

      ELSE.

        ls_vuelos-num_pl_totales  = lv_pl_totales.
        ls_vuelos-num_pl_ocupadas = lv_pl_ocupadas.
        ls_vuelos-num_pl_libres = lv_pl_libres.
        ls_vuelos-tipo_cliente = 'RECHAZADO - NO CABEN'.

         APPEND ls_vuelos TO lt_vuelos.
       out->write( |Codigo { ls_vuelos-codigo_vuelo }: RECHAZADO ({ lv_solicitadas } pl.) -> Solo quedan { lv_pl_libres } libres.| ).
      EXIT.

    ENDIF.
    lv_contador_vuelos = lv_contador_vuelos + 1.


    ENDWHILE.


        out->write( | | ).
        out->write( | | ).
        out->write( |TABLA INTERNA DEFINIDA| ).
        out->write( lt_vuelos ).




  ENDMETHOD.
ENDCLASS.
