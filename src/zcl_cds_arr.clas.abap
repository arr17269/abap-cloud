CLASS zcl_cds_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cds_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  SELECT FROM zi_20_der AS Booking
      FIELDS Booking~TravelId,
             Booking~BookingId,
             Booking~CarrierId,
             \_Travel-AgencyId,
             \_Travel\_Agency-name              AS AgencyName,
             \_Travel\_Customer-customer_id     AS CustomerId,
             concat_with_space( \_Travel\_Customer-first_name,
                                \_Travel\_Customer-last_name, 1 ) AS CustomerName
      WHERE  \_Travel\_Customer-last_name LIKE 'M%'
      ORDER BY \_Travel\_Customer-last_name, Booking~TravelId
      INTO TABLE @DATA(lt_resultados)
      UP TO 20 ROWS.


if sy-subrc = 0.
    out->write( lt_resultados ).
endif.
  ENDMETHOD.

ENDCLASS.




