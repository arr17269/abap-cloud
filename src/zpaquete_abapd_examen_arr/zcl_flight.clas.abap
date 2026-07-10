CLASS zcl_flight DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: ty_carrier_id    TYPE /dmo/carrier_id,
           ty_connection_id TYPE /dmo/connection_id.

    DATA: carrier_id    TYPE /dmo/carrier_id    READ-ONLY,
          connection_id TYPE /dmo/connection_id  READ-ONLY,
          airport_from  TYPE /dmo/airport_from_id READ-ONLY,
          airport_to    TYPE /dmo/airport_to_id   READ-ONLY,
          plane_type    TYPE /dmo/plane_type_id   READ-ONLY.

    METHODS constructor
      IMPORTING
        iv_carrier_id    TYPE /dmo/carrier_id
        iv_connection_id TYPE /dmo/connection_id
        iv_plane_type    TYPE /dmo/plane_type_id
      RAISING
        zcx_c_abapd_no_connection.

ENDCLASS.

CLASS zcl_flight IMPLEMENTATION.

  METHOD constructor.

    carrier_id    = iv_carrier_id.
    connection_id = iv_connection_id.
    plane_type    = iv_plane_type.

    SELECT SINGLE airport_from_id, airport_to_id
      FROM /dmo/connection
      WHERE carrier_id    = @iv_carrier_id
        AND connection_id = @iv_connection_id
      INTO (@airport_from, @airport_to).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_c_abapd_no_connection.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
