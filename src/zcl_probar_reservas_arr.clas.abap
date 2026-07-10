CLASS zcl_probar_reservas_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_probar_reservas_arr IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(gestor) = NEW zcl_gestor_reservas_arr( ).

    "==========================================
    " Escenario 1: reserva correcta
    "==========================================
    TRY.
        gestor->reservar_pista(
          hora          = 10
          num_jugadores = 4
          nombre_pista  = 'PISTA_2' ).

        out->write( '✅ Escenario 1 (correcto): reserva realizada sin errores' ).

      CATCH zcx_reserva_no_valida_arr INTO DATA(error1).
        out->write( |❌ Escenario 1: no debería haber dado error, pero dio: { error1->get_text( ) }| ).
    ENDTRY.

    out->write( '------------------------------------------------' ).

    "==========================================
    " Escenario 2: hora inválida
    "==========================================
    TRY.
        gestor->reservar_pista(
          hora          = 6
          num_jugadores = 4
          nombre_pista  = 'PISTA_2' ).

        out->write( '❌ Escenario 2: no debería haber pasado, pero no dio error' ).

      CATCH zcx_reserva_no_valida_arr INTO DATA(error2).
        out->write( |✅ Escenario 2 (hora inválida) - Motivo: { error2->motivo }| ).
        out->write( |   Mensaje: { error2->get_text( ) }| ).
    ENDTRY.

    out->write( '------------------------------------------------' ).

    "==========================================
    " Escenario 3: número de jugadores incorrecto
    "==========================================
    TRY.
        gestor->reservar_pista(
          hora          = 10
          num_jugadores = 2
          nombre_pista  = 'PISTA_2' ).

        out->write( '❌ Escenario 3: no debería haber pasado, pero no dio error' ).

      CATCH zcx_reserva_no_valida_arr INTO DATA(error3).
        out->write( |✅ Escenario 3 (jugadores incorrecto) - Motivo: { error3->motivo }| ).
        out->write( |   Mensaje: { error3->get_text( ) }| ).
    ENDTRY.

    out->write( '------------------------------------------------' ).

    "==========================================
    " Escenario 4: PISTA_1 siempre ocupada
    "==========================================
    TRY.
        gestor->reservar_pista(
          hora          = 10
          num_jugadores = 4
          nombre_pista  = 'PISTA_1' ).

        out->write( '❌ Escenario 4: no debería haber pasado, pero no dio error' ).

      CATCH zcx_reserva_no_valida_arr INTO DATA(error4).
        out->write( |✅ Escenario 4 (pista ocupada) - Motivo: { error4->motivo }| ).
        out->write( |   Mensaje: { error4->get_text( ) }| ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
