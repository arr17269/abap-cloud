CLASS z_prueba_examen_1111 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_prueba_examen_1111 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    " 1. Instanciamos nuestra clase de modelo (Paso 3)
    DATA(lo_model) = NEW zcl_1111_booking_model( ).

    out->write( '--- PRUEBA 1: RESERVA EXISTENTE ---' ).

    TRY.
        " Llamamos al método con IDs que sí existen.
        " Nota: Si estos IDs no existen en tu sistema, cámbialos por unos reales de /dmo/booking
        DATA(ls_booking) = lo_model->get_booking(
                             iv_travel_id  = '00000001'
                             iv_booking_id = '0001'
                           ).

        out->write( 'Reserva encontrada con éxito:' ).
        out->write( ls_booking ).

      CATCH zcx_1111_no_booking INTO DATA(lx_error).
        out->write( 'Error inesperado en Prueba 1:' ).
        out->write( lx_error->get_text( ) ).
    ENDTRY.


    out->write( ' ' ). " Línea en blanco para separar
    out->write( '--- PRUEBA 2: RESERVA NO EXISTENTE ---' ).

    TRY.
        " Llamamos al método con IDs inventados para forzar el error
        DATA(ls_booking_fail) = lo_model->get_booking(
                                  iv_travel_id  = '00000018'
                                  iv_booking_id = '0018'
                                ).

        out->write( '¡Error! El sistema dice que encontró una reserva que no existe.' ).

      CATCH zcx_1111_no_booking INTO lx_error.
        " Capturamos el error y mostramos el mensaje dinámico de tu clase de mensajes
        out->write( 'Excepción capturada correctamente:' ).
        out->write( lx_error->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
