CLASS zcl_1111_booking_model DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    " Definimos el método para obtener la reserva
    METHODS get_booking
      IMPORTING
        iv_travel_id     TYPE /dmo/travel_id
        iv_booking_id    TYPE /dmo/booking_id
      RETURNING
        VALUE(rs_booking) TYPE /dmo/booking
      RAISING
        zcx_1111_no_booking. " Declaramos que este método puede lanzar tu excepción

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1111_booking_model IMPLEMENTATION.

  METHOD get_booking.
    " 1. Intentamos leer la tabla /dmo/booking con las claves recibidas
    SELECT SINGLE *
      FROM /dmo/booking
      WHERE travel_id  = @iv_travel_id
        AND booking_id = @iv_booking_id
      INTO @rs_booking.

    " 2. Si el sistema no encuentra el registro (SUBRC diferente de 0)
    IF sy-subrc <> 0.
      " Lanzamos la excepción pasando los códigos erróneos al constructor
      RAISE EXCEPTION TYPE zcx_1111_no_booking
        EXPORTING
          travel_id  = iv_travel_id
          booking_id = iv_booking_id.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
