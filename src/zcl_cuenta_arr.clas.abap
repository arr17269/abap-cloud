CLASS zcl_cuenta_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  METHODS constructor
        IMPORTING
        iv_saldo_inicial type decfloat34 DEFAULT 0.  "se termina con un punto"

   METHODS ingresar
        IMPORTING
        iv_importe type decfloat34
            RETURNING
            VALUE(rv_saldo_nuevo) TYPE decfloat34.    "se termina con un punto"

  METHODS retirar
        IMPORTING
        iv_importe type decfloat34
            RAISING
        zcx_saldo_insuficiente_arr.                     "se termina con un punto"

  METHODS mostrar_saldo
        RETURNING VALUE(rv_saldo) type  decfloat34.     "se termina con un punto"

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mv_saldo TYPE decfloat34.                       "member value

ENDCLASS.



CLASS zcl_cuenta_arr IMPLEMENTATION.

  METHOD constructor.
  mv_saldo = iv_saldo_inicial.

  ENDMETHOD.

  METHOD ingresar.
  mv_saldo = mv_saldo + iv_importe.

  ENDMETHOD.

  METHOD mostrar_saldo.
  rv_saldo = mv_saldo.

  ENDMETHOD.

  METHOD retirar.

    IF iv_importe > mv_saldo.
        RAISE EXCEPTION type zcx_saldo_insuficiente_arr.
    ENDIF.
         mv_saldo = mv_saldo - iv_importe.

  ENDMETHOD.

ENDCLASS.
