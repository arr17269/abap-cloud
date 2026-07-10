INTERFACE zif_flight_manager_arr   PUBLIC.

  TYPES:
    BEGIN OF ty_flight,
      aerolinea TYPE c LENGTH 2,
      num_vuelo TYPE n LENGTH 4,
      origen    TYPE c LENGTH 3,
      destino   TYPE c LENGTH 3,
      precio    TYPE p LENGTH 9 DECIMALS 2,
    END OF ty_flight,
   tt_flights TYPE STANDARD TABLE OF ty_flight WITH EMPTY KEY,
    ty_total   TYPE p LENGTH 11 DECIMALS 2.

  METHODS:
   add_flight
      IMPORTING
        is_flight TYPE ty_flight
      RAISING
        zcx_flight_error_arr,

    get_flights_by_airline
      IMPORTING
        iv_aerolinea TYPE ty_flight-aerolinea
      RETURNING VALUE(rt_flights)  TYPE tt_flights,

    get_cheapest_flight
      RETURNING VALUE(rs_flight) TYPE ty_flight,

    get_total_revenue
      RETURNING VALUE(rv_total) TYPE ty_total.

ENDINTERFACE.
