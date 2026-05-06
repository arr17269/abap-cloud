CLASS zcl_descuentos_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_descuentos_arr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA lv_edad TYPE i .
    DATA lv_persona TYPE string VALUE 'adolescente'.
    DATA lv_tarifa TYPE i.



    IF lv_persona  = 'padre'.

      lv_edad = 45.
      lv_tarifa = 1.

    ELSEIF lv_persona = 'hijo'.

      lv_edad = 2.
      lv_tarifa = 1.
    ELSE.

      IF lv_persona  = 'adolescente'.

        lv_edad = 17.
        lv_tarifa = 1.

      ELSEIF lv_persona = 'anciano'.

        lv_edad = 70.
        lv_tarifa = 1.
      ELSE.
        lv_tarifa = 0.

      ENDIF.

    ENDIF.


    IF lv_tarifa = 1 .
      IF lv_edad < 4.

        out->write( ' entra gratis' ).

      ELSEIF lv_edad >= 4 AND lv_edad <= 18 OR lv_edad <= 70.

        out->write( '5 euros ' ).

      ELSE.

        out->write( '10 euros ' ).

      ENDIF.
    ELSE.

      out->write( 'tarifa no contemplada ' ).

    ENDIF.


    out->write( lv_tarifa ).






  ENDMETHOD.

ENDCLASS.
