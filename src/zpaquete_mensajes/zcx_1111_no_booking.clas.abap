CLASS zcx_1111_no_booking DEFINITION
  PUBLIC
  INHERITING FROM cx_no_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    " 1. Implementamos las interfaces para conectar los mensajes T100
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    " 2. Creamos la constante que apunta al mensaje '001' de tu clase ZC_MENSAJES_ARR
    CONSTANTS:
      BEGIN OF booking_not_found,
        msgid TYPE symsgid VALUE 'ZC_MENSAJES_ARR',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'MV_TRAVEL_ID',
        attr2 TYPE scx_attrname VALUE 'MV_BOOKING_ID',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF booking_not_found .

    " 3. Atributos públicos para guardar los IDs reales de la reserva que falló
    DATA mv_travel_id  TYPE /dmo/travel_id.
    DATA mv_booking_id TYPE /dmo/booking_id.

    " 4. Definición del Constructor (el motor que arranca la excepción)
    METHODS constructor
      IMPORTING
        textid       LIKE if_t100_message=>t100key OPTIONAL
        previous     LIKE previous OPTIONAL
        travel_id    TYPE /dmo/travel_id OPTIONAL
        booking_id   TYPE /dmo/booking_id OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_1111_no_booking IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    " Llamamos al constructor de la superclase (obligatorio)
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.

    " Guardamos los IDs que nos pasen en nuestros atributos internos
    me->mv_travel_id  = travel_id.
    me->mv_booking_id = booking_id.

    " Si no nos pasan un texto específico, usamos por defecto nuestro mensaje 001
    CLEAR me->textid.
    IF textid IS INITIAL.
      IF_T100_MESSAGE~t100key = zcx_1111_no_booking=>booking_not_found.
    ELSE.
      IF_T100_MESSAGE~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

