CLASS zcx_flight_error_arr DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA mv_mensaje TYPE string READ-ONLY.

    METHODS constructor
      IMPORTING
        mensaje TYPE string OPTIONAL
        previous LIKE previous OPTIONAL.

ENDCLASS.


CLASS zcx_flight_error_arr IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    me->mv_mensaje = mensaje.
  ENDMETHOD.

ENDCLASS.

