CLASS zcl_ejerestructuras_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejerestructuras_arr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  types: BEGIN OF ty_flights,
        price type /dmo/flight_price ,"para coger tipos de la bbdd de /dmo/flight
        number_fly type i,
        currency_code type /dmo/currency_code,
        seat type /dmo/plane_seats_max,
        plane_type_id type /dmo/plane_type_id,
        email type string,
        End of ty_flights.



  DATA lt_flights TYPE table of ty_flights.
  data ls_INCLUDE type ty_flights.

  ls_INCLUDE-price = 1230.
  ls_INCLUDE-number_fly = 14.
  ls_INCLUDE-currency_code = 'Eu'.
  ls_INCLUDE-seat = 22.
  ls_INCLUDE-plane_type_id = 'AD'.
  ls_INCLUDE-email = 'blablabla@yoquese'.

            out->write( ls_INCLUDE ).












  ENDMETHOD.

ENDCLASS.
