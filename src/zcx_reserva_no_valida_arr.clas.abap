CLASS zcx_reserva_no_valida_arr DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: motivo                  TYPE string.
    DATA: hora_recibida           TYPE i.
    DATA: num_jugadores_recibido  TYPE i.
    DATA: nombre_pista_recibido   TYPE string.

    METHODS constructor
      IMPORTING
        !previous                TYPE REF TO cx_root OPTIONAL
        !motivo                  TYPE string OPTIONAL
        !hora_recibida           TYPE i OPTIONAL
        !num_jugadores_recibido  TYPE i OPTIONAL
        !nombre_pista_recibido   TYPE string OPTIONAL.

    METHODS get_text REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_reserva_no_valida_arr IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    me->motivo                 = motivo.
    me->hora_recibida          = hora_recibida.
    me->num_jugadores_recibido = num_jugadores_recibido.
    me->nombre_pista_recibido  = nombre_pista_recibido.
  ENDMETHOD.


  METHOD get_text.
    CASE me->motivo.
      WHEN 'HORA'.
        result = |Hora fuera de servicio: { me->hora_recibida } (el club abre de 8 a 23h)|.
      WHEN 'JUGADORES'.
        result = |Número de jugadores incorrecto: { me->num_jugadores_recibido } (se necesitan exactamente 4)|.
      WHEN 'PISTA'.
        result = |La pista { me->nombre_pista_recibido } no está disponible|.
      WHEN OTHERS.
        result = 'Reserva no válida'.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
