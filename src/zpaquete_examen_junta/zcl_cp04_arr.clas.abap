CLASS zcl_cp04_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cp04_arr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

   "=====================================================
    " Tarea 4.1 - Análisis (ver también el documento/comentario aparte)
    "---------------------------------------------------------------
    " La estructura local ty_reserva del CP2 usaba tipos genéricos
    " (i, c, n, string, p, d), sin etiquetas ni significado semántico.
    " Campos como aerolinea, num_vuelo, pasajero, precio y estado se
    " repiten en varios casos prácticos y tienen significado de negocio
    " claro -> se han convertido en elementos de datos reutilizables
    " (ZDE_AIRLINE_ARR, ZDE_FLIGHT_NUM_ARR, ZDE_PASSENGER_ARR,
    " ZDE_FLIGHT_PRICE_ARR, ZDE_BOOKING_STATUS_ARR, ZDE_RESERVA_ID_ARR).
    " El campo fecha se ha dejado como DATS predefinido, sin elemento
    " de datos propio, porque no aporta semántica adicional.
    "=====================================================

    " Ya NO se declara TYPES: BEGIN OF ty_reserva ... END OF ty_reserva.
    " Se usa directamente el tipo tabla global del diccionario:
    DATA(reservas) = VALUE ztt_bookings_ARR(
      ( booking_id = 1 airline = 'LH' flight_num = '0400' passenger = 'Ana García'   booking_date = '20260515' flight_price = '899.00'  booking_status = 'A' )
      ( booking_id = 2 airline = 'IB' flight_num = '3740' passenger = 'Carlos López' booking_date = '20260515' flight_price = '120.00'  booking_status = 'A' )
      ( booking_id = 3 airline = 'AA' flight_num = '0017' passenger = 'John Smith'   booking_date = '20260520' flight_price = '450.50'  booking_status = 'A' )
      ( booking_id = 4 airline = 'LH' flight_num = '0455' passenger = 'María Pérez'  booking_date = '20260520' flight_price = '310.75'  booking_status = 'A' )
      ( booking_id = 5 airline = 'IB' flight_num = '3740' passenger = 'Pedro Ruiz'   booking_date = '20260515' flight_price = '120.00'  booking_status = 'C' )
      ( booking_id = 6 airline = 'SQ' flight_num = '0026' passenger = 'Lisa Tan'     booking_date = '20260601' flight_price = '1250.00' booking_status = 'A' )
      ( booking_id = 7 airline = 'LH' flight_num = '0400' passenger = 'Hans Müller'  booking_date = '20260515' flight_price = '899.00'  booking_status = 'A' )
      ( booking_id = 8 airline = 'AA' flight_num = '0064' passenger = 'Sarah Jones'  booking_date = '20260525' flight_price = '510.00'  booking_status = 'A' )
    ).

    "=====================================================
    " Tarea 4.2 (heredada) - Altas de reservas
    "=====================================================
    INSERT VALUE zst_booking_ARR( booking_id = 9  airline = 'IB' flight_num = '3950'
                                  passenger = 'Elena Martín' booking_date = '20260601'
                                  flight_price = '275.30' booking_status = 'A' )
           INTO TABLE reservas.

    INSERT VALUE zst_booking_arr( booking_id = 10 airline = 'LH' flight_num = '2030'
                                  passenger = 'Franz Weber' booking_date = '20260610'
                                  flight_price = '95.00' booking_status = 'A' )
           INTO TABLE reservas.

    out->write( '--- Tarea 2.1: Tabla completa tras las altas ---' ).
    LOOP AT reservas INTO DATA(r1).
      out->write( |{ r1-booking_id } { r1-airline }{ r1-flight_num } - { r1-passenger } - { r1-flight_price } € - { r1-booking_status }| ).
    ENDLOOP.

    "=====================================================
    " Tarea 4.3 (heredada) - Modificaciones
    "=====================================================
    READ TABLE reservas REFERENCE INTO DATA(dref3) WITH KEY booking_id = 3.
    IF sy-subrc = 0.
      dref3->flight_price = '480.00'.
    ENDIF.

    LOOP AT reservas REFERENCE INTO DATA(dref_lh) WHERE airline = 'LH'.
      dref_lh->flight_price = dref_lh->flight_price * '0.9'.
    ENDLOOP.

    out->write( '' ).
    out->write( '--- Tarea 4.3: Registros modificados ---' ).
    LOOP AT reservas INTO DATA(r2) WHERE booking_id = 3 OR airline = 'LH'.
      out->write( |{ r2-booking_id } { r2-airline }{ r2-flight_num } - nuevo precio { r2-flight_price } €| ).
    ENDLOOP.

    "=====================================================
    " Tarea 4.4 (heredada) - Cancelaciones y borrados
    "=====================================================
    READ TABLE reservas REFERENCE INTO DATA(dref4) WITH KEY booking_id = 4.
    IF sy-subrc = 0.
      dref4->booking_status = 'C'.
    ENDIF.

    DATA(num_antes) = lines( reservas ).
    DELETE reservas WHERE booking_status = 'C'.
    DATA(num_eliminados) = num_antes - lines( reservas ).

    out->write( '' ).
    out->write( '--- Tarea 4.4: Tabla tras cancelar ID 4 y borrar estado C ---' ).
    LOOP AT reservas INTO DATA(r3).
      out->write( |{ r3-booking_id } { r3-airline }{ r3-flight_num } - { r3-passenger } - { r3-booking_status }| ).
    ENDLOOP.
    out->write( |Registros eliminados: { num_eliminados }| ).

    "=====================================================
    " Tarea 4.5 (heredada) - Búsquedas
    "=====================================================
    out->write( '' ).
    out->write( '--- Tarea 4.5: Búsquedas ---' ).

    READ TABLE reservas TRANSPORTING NO FIELDS WITH KEY passenger = 'Lisa Tan'.
    IF sy-subrc = 0.
      out->write( 'Existe una reserva para Lisa Tan' ).
    ELSE.
      out->write( 'No existe reserva para Lisa Tan' ).
    ENDIF.

    READ TABLE reservas REFERENCE INTO DATA(dref6) WITH KEY booking_id = 6.
    IF sy-subrc = 0.
      out->write( |Reserva 6: { dref6->passenger } - { dref6->flight_price } €| ).
    ENDIF.

    DATA(pasajero_1) = reservas[ booking_id = 1 ]-passenger.
    out->write( |Pasajero de la reserva 1: { pasajero_1 }| ).

    "=====================================================
    " Tarea 4.6 (heredada) - Agrupación y agregados
    "=====================================================
    out->write( '' ).
    out->write( '--- Tarea 4.6: Informe por aerolínea (reservas activas) ---' ).

    DATA(reservas_activas) = FILTER ztt_bookings_arr( reservas USING KEY by_status WHERE booking_status = 'A' ).

    LOOP AT reservas_activas INTO DATA(res) GROUP BY res-airline INTO DATA(grupo).
      DATA(num_reservas) = REDUCE i( INIT n = 0 FOR wa IN GROUP grupo NEXT n = n + 1 ).
      DATA(precio_total) = REDUCE decfloat34( INIT s = 0 FOR wa IN GROUP grupo NEXT s = s + wa-flight_price ).
      DATA(precio_medio) = round( val = precio_total / num_reservas dec = 2 ).

      out->write( |{ grupo }: { num_reservas } reservas, total { precio_total } €, media { precio_medio } €| ).
    ENDLOOP.

    "=====================================================
    " Tarea 4.6 - Reflexión
    "---------------------------------------------------------------
    " ¿Ventajas de los tipos del diccionario frente a tipos locales?
    "   - Reutilización real entre clases, CDS views, RAP, APIs.
    "   - Cambios centralizados: si cambia la longitud de un campo,
    "     se corrige en un solo sitio y todo lo que lo usa se actualiza.
    "   - Semántica añadida: etiquetas de campo, textos de ayuda,
    "     lo que mejora la UI generada automáticamente (Fiori Elements, ALV).
    "   - Consistencia de tipos entre distintos desarrollos del mismo
    "     dominio de negocio (todas las "aerolineas" del sistema con
    "     el mismo tipo y longitud).
    "
    " ¿Cuándo seguir usando TYPES locales?
    "   - Tipos auxiliares de uso interno y muy específico de un único
    "     método/clase, sin vocación de reutilización.
    "   - Prototipos rápidos o pruebas de concepto donde crear objetos
    "     DDIC formales sería sobrecoste innecesario.
    "
    " ¿Elementos de datos y dominios en ABAP clásico vs. ABAP Cloud?
    "   - En ABAP clásico, un dominio define el tipo técnico y los
    "     valores fijos/rango, y el elemento de datos "hereda" ese
    "     dominio añadiendo las etiquetas. En ABAP Cloud (release
    "     restringido) esa distinción se simplifica: los elementos de
    "     datos suelen basarse directamente en un "Predefined Type"
    "     sin pasar por un dominio propio, salvo que realmente se
    "     necesite reutilizar validaciones/valores fijos entre varios
    "     elementos de datos, en cuyo caso el dominio sigue existiendo
    "     como objeto también en Cloud.
    "=====================================================

  ENDMETHOD.

ENDCLASS.




