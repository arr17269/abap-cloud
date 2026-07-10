CLASS zcl_flight_manager_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES zif_flight_manager_arr.

    ALIASES: add_flight              FOR zif_flight_manager_arr~add_flight,
            get_flights_by_airline   FOR zif_flight_manager_arr~get_flights_by_airline,
            get_cheapest_flight      FOR zif_flight_manager_arr~get_cheapest_flight,
            get_total_revenue        FOR zif_flight_manager_arr~get_total_revenue.




    METHODS constructor
      IMPORTING
        it_flights TYPE zif_flight_manager_arr=>tt_flights OPTIONAL.


  PRIVATE SECTION.

    DATA mt_flights TYPE zif_flight_manager_arr=>tt_flights.


ENDCLASS.



CLASS zcl_flight_manager_arr IMPLEMENTATION.

  METHOD constructor.

    IF it_flights IS SUPPLIED.
      mt_flights = it_flights.
    ENDIF.

  ENDMETHOD.

  METHOD zif_flight_manager_arr~add_flight.

    " Validar que el precio sea mayor que 0
    IF is_flight-precio <= 0.

      RAISE EXCEPTION TYPE zcx_flight_error_arr
        EXPORTING
          mensaje = 'El precio debe ser mayor que 0'.

    ENDIF.

    " Validar que el vuelo no exista ya
    IF line_exists(
         mt_flights[
           aerolinea = is_flight-aerolinea
           num_vuelo = is_flight-num_vuelo ] ).

      RAISE EXCEPTION TYPE zcx_flight_error_arr
        EXPORTING
          mensaje = |El vuelo { is_flight-aerolinea }-{ is_flight-num_vuelo } ya existe.|.

    ENDIF.

    " Añadir el vuelo a la tabla
    APPEND is_flight TO mt_flights.

  ENDMETHOD.


  METHOD zif_flight_manager_arr~get_cheapest_flight.

    " Si no hay vuelos, devolvemos una estructura vacía
    IF mt_flights IS INITIAL.
      RETURN.
    ENDIF.

    " Buscamos el vuelo más barato
    rs_flight =
      REDUCE zif_flight_manager_arr=>ty_flight(
        INIT cheapest = VALUE zif_flight_manager_arr=>ty_flight(
                          precio = CONV #( '999999.99' ) )
        FOR wa IN mt_flights
        NEXT cheapest =
          COND #(
            WHEN wa-precio < cheapest-precio
            THEN wa
            ELSE cheapest )
      ).

  ENDMETHOD.



  METHOD zif_flight_manager_arr~get_flights_by_airline.

    rt_flights =
      VALUE #(
        FOR wa IN mt_flights
        WHERE ( aerolinea = iv_aerolinea )
        ( wa )
      ).

  ENDMETHOD.

  METHOD zif_flight_manager_arr~get_total_revenue.

    rv_total =
      REDUCE zif_flight_manager_arr=>ty_total(
        INIT total = CONV zif_flight_manager_arr=>ty_total( 0 )
        FOR wa IN mt_flights
        NEXT total = total + wa-precio ).

  ENDMETHOD.


ENDCLASS.






