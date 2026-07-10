CLASS zcl_prueba_cuenta_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_prueba_cuenta_arr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

"crear cuenta e ingresar dinero
out->write( 'Ingresar dinero' ).

DATA(lo_cuenta) = new zcl_cuenta_arr( iv_saldo_inicial = 100 ).   "parentesis sin espacios

lo_cuenta->ingresar( iv_importe = 50 ).
out->write( |Prueba 1: Saldo tras ingresar 50 (esperando 150):  { lo_cuenta->mostrar_saldo(  ) } | ).

"retirar dinero.
out->write( | | ).
out->write( 'Retirar dinero' ).

try.
lo_cuenta->retirar( iv_importe = 30 ).
out->write( |Prueba 2: retirar 30 (esperando 120): { lo_cuenta->mostrar_saldo( ) } | ).
CATCH zcx_saldo_insuficiente_arr.
out->write( |Prueba 2: Error: No deberia haber saltado la excepcion | ).
ENDTRY.

"retirar mas dinero del que se tiene.
out->write( | | ).
out->write( 'Retirar mas dinero del que se tiene' ).

try.
lo_cuenta->retirar( iv_importe = 200 ).
out->write( |Prueba 3: retirar 200 (no hay suficiente fondos ): { lo_cuenta->mostrar_saldo( ) } | ).
catch zcx_saldo_insuficiente_arr.

out->write( |Prueba 3: Error: Salto la excepcion | ).
ENDTRY.
  ENDMETHOD.

ENDCLASS.
