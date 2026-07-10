CLASS zcl_gestor_reservas_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS reservar_pista
      IMPORTING
        !hora           TYPE i
        !num_jugadores  TYPE i
        !nombre_pista   TYPE string
    RAISING
        zcx_reserva_no_valida_arr.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gestor_reservas_arr IMPLEMENTATION.

  METHOD reservar_pista.

    " Regla 1: horario de servicio (8h a 23h)
    IF hora < 8 OR hora > 23.
      RAISE EXCEPTION TYPE zcx_reserva_no_valida_arr
        EXPORTING
          motivo        = 'HORA'
          hora_recibida = hora.
    ENDIF.

    " Regla 2: el pádel se juega con exactamente 4 jugadores
    IF num_jugadores <> 4.
      RAISE EXCEPTION TYPE zcx_reserva_no_valida_arr
        EXPORTING
          motivo                 = 'JUGADORES'
          num_jugadores_recibido = num_jugadores.
    ENDIF.

    " Regla 3: PISTA_1 siempre está ocupada
    IF nombre_pista = 'PISTA_1'.
      RAISE EXCEPTION TYPE zcx_reserva_no_valida_arr
        EXPORTING
          motivo                = 'PISTA'
          nombre_pista_recibido = nombre_pista.
    ENDIF.

    " Si llega aquí, la reserva es válida
    " (no hace falta hacer nada más en este ejercicio)

  ENDMETHOD.

ENDCLASS.
