CLASS zcl_a3m_passenger_flight DEFINITION
  PUBLIC
  INHERITING FROM zcl_flight
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_carrier_id    TYPE /dmo/carrier_id
        iv_connection_id TYPE /dmo/connection_id
        iv_plane_type    TYPE /dmo/plane_type_id
      RAISING
        zcx_c_abapd_no_connection.

  PRIVATE SECTION.
    DATA seats_max TYPE i.

ENDCLASS.

CLASS zcl_a3m_passenger_flight IMPLEMENTATION.

  METHOD constructor.

    super->constructor(
      iv_carrier_id    = iv_carrier_id
      iv_connection_id = iv_connection_id
      iv_plane_type    = iv_plane_type ).

    SELECT SINGLE maximumseats
      FROM zi_cabapd_passenger
      WHERE planetypeid = @iv_plane_type
      INTO @seats_max.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_c_abapd_no_connection.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
