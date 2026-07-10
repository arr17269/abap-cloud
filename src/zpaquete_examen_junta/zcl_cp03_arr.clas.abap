CLASS zcl_cp03_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cp03_arr IMPLEMENTATION.

 METHOD if_oo_adt_classrun~main.

  DATA(lo_manager) = NEW zcl_flight_manager_arr( ).

  DATA ls_flight TYPE zif_flight_manager_arr=>ty_flight.

*--------------------------------------------------------------------
* VUELO 1
*--------------------------------------------------------------------
TRY.
  ls_flight-aerolinea = 'IB'.
  ls_flight-num_vuelo = '1001'.
  ls_flight-origen = 'MAD'.
  ls_flight-destino = 'BCN'.
  ls_flight-precio = '120.50'.

  lo_manager->add_flight( ls_flight ).

   CATCH zcx_flight_error_arr INTO DATA(lx_error).
    out->write(  |ERROR: { lx_error->mv_mensaje }| ).
 ENDTRY.

*--------------------------------------------------------------------
* VUELO 2
*--------------------------------------------------------------------
TRY.
  CLEAR ls_flight.

  ls_flight-aerolinea = 'IB'.
  ls_flight-num_vuelo = '1002'.
  ls_flight-origen = 'MAD'.
  ls_flight-destino = 'BIO'.
  ls_flight-precio = '95.00'.

  lo_manager->add_flight( ls_flight ).

  CATCH zcx_flight_error_arr INTO lx_error.
    out->write(  |ERROR: { lx_error->mv_mensaje }| ).
 ENDTRY.

*--------------------------------------------------------------------
* VUELO 3
*--------------------------------------------------------------------
TRY.
  CLEAR ls_flight.

  ls_flight-aerolinea = 'LH'.
  ls_flight-num_vuelo = '2001'.
  ls_flight-origen = 'FRA'.
  ls_flight-destino = 'MAD'.
  ls_flight-precio = '180.00'.

  lo_manager->add_flight( ls_flight ).


   CATCH zcx_flight_error_arr INTO lx_error.
    out->write(  |ERROR: { lx_error->mv_mensaje }| ).
 ENDTRY.
*--------------------------------------------------------------------
* VUELO 4
*--------------------------------------------------------------------
TRY.
  CLEAR ls_flight.

  ls_flight-aerolinea = 'AF'.
  ls_flight-num_vuelo = '3001'.
  ls_flight-origen = 'PAR'.
  ls_flight-destino = 'ROM'.
  ls_flight-precio = '160.00'.

  lo_manager->add_flight( ls_flight ).

   CATCH zcx_flight_error_arr INTO lx_error.
    out->write(  |ERROR: { lx_error->mv_mensaje }| ).
 ENDTRY.

*--------------------------------------------------------------------
* VUELO 5
*--------------------------------------------------------------------
TRY.
  CLEAR ls_flight.

  ls_flight-aerolinea = 'LH'.
  ls_flight-num_vuelo = '2002'.
  ls_flight-origen = 'FRA'.
  ls_flight-destino = 'BCN'.
  ls_flight-precio = '140.00'.

  lo_manager->add_flight( ls_flight ).

   CATCH zcx_flight_error_arr INTO lx_error.

    out->write(  |ERROR: { lx_error->mv_mensaje }| ).

 ENDTRY.

*--------------------------------------------------------------------
* PRUEBA 1 - Precio negativo
*--------------------------------------------------------------------

  TRY.

      CLEAR ls_flight.

      ls_flight-aerolinea = 'IB'.
      ls_flight-num_vuelo = '9999'.
      ls_flight-origen = 'MAD'.
      ls_flight-destino = 'LON'.
      ls_flight-precio = '-20'.

      lo_manager->add_flight( ls_flight ).

    CATCH zcx_flight_error_arr INTO lx_error.

      out->write(  |ERROR: { lx_error->mv_mensaje }| ).

  ENDTRY.

*--------------------------------------------------------------------
* PRUEBA 2 - Vuelo duplicado
*--------------------------------------------------------------------

  TRY.

      CLEAR ls_flight.

      ls_flight-aerolinea = 'IB'.
      ls_flight-num_vuelo = '1001'.
      ls_flight-origen = 'MAD'.
      ls_flight-destino = 'BCN'.
      ls_flight-precio = '120'.

      lo_manager->add_flight( ls_flight ).

    CATCH zcx_flight_error_arr INTO lx_error.

      out->write(
        |ERROR: { lx_error->mv_mensaje }| ).

  ENDTRY.

*--------------------------------------------------------------------
* Mostrar vuelos de Iberia
*--------------------------------------------------------------------

  DATA(lt_vuelos) =
      lo_manager->get_flights_by_airline(
          iv_aerolinea = 'IB' ).

  out->write( '=== VUELOS IBERIA ===' ).

  LOOP AT lt_vuelos INTO DATA(ls_vuelo).

    out->write(
      |{ ls_vuelo-num_vuelo } { ls_vuelo-origen } -> { ls_vuelo-destino } { ls_vuelo-precio } €| ).

  ENDLOOP.

*--------------------------------------------------------------------
* Vuelo más barato
*--------------------------------------------------------------------

  DATA(ls_barato) =
      lo_manager->get_cheapest_flight( ).



  out->write(
      |Vuelo más barato: { ls_barato-aerolinea } { ls_barato-num_vuelo } Precio { ls_barato-precio } €| ).

*--------------------------------------------------------------------
* Facturación total
*--------------------------------------------------------------------

  DATA(lv_total) =
      lo_manager->get_total_revenue( ).

  out->write(
      |Facturación total: { lv_total } €| ).




ENDMETHOD.

ENDCLASS.
