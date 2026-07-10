CLASS zcl_cp02_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES:
      BEGIN OF ty_reserva,
        id_reserva TYPE i,
        aerolinea  TYPE c LENGTH 2,
        num_vuelo  TYPE n LENGTH 4,
        pasajero   TYPE string,
        fecha      TYPE d,
        precio     TYPE p LENGTH 9 DECIMALS 2,
        estado     TYPE c LENGTH 1,
      END OF ty_reserva,
      tt_reservas TYPE STANDARD TABLE OF ty_reserva WITH EMPTY KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_cp02_arr IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " ===== DATOS DE PARTIDA =====
    DATA(lt_reservas) = VALUE tt_reservas(
      ( id_reserva = 1  aerolinea = 'LH' num_vuelo = '0400' pasajero = 'Ana García'    fecha = '20260515' precio = '899.00'  estado = 'A' )
      ( id_reserva = 2  aerolinea = 'IB' num_vuelo = '3740' pasajero = 'Carlos López'  fecha = '20260515' precio = '120.00'  estado = 'A' )
      ( id_reserva = 3  aerolinea = 'AA' num_vuelo = '0017' pasajero = 'John Smith'    fecha = '20260520' precio = '450.50'  estado = 'A' )
      ( id_reserva = 4  aerolinea = 'LH' num_vuelo = '0455' pasajero = 'María Pérez'   fecha = '20260520' precio = '310.75'  estado = 'A' )
      ( id_reserva = 5  aerolinea = 'IB' num_vuelo = '3740' pasajero = 'Pedro Ruiz'    fecha = '20260515' precio = '120.00'  estado = 'C' )
      ( id_reserva = 6  aerolinea = 'SQ' num_vuelo = '0026' pasajero = 'Lisa Tan'      fecha = '20260601' precio = '1250.00' estado = 'A' )
      ( id_reserva = 7  aerolinea = 'LH' num_vuelo = '0400' pasajero = 'Hans Müller'   fecha = '20260515' precio = '899.00'  estado = 'A' )
      ( id_reserva = 8  aerolinea = 'AA' num_vuelo = '0064' pasajero = 'Sarah Jones'   fecha = '20260525' precio = '510.00'  estado = 'A' )
    ).

    " ===== TAREA 2.1: Altas de reservas =====
    out->write( '===== TAREA 2.1: Altas de reservas =====' ).

    INSERT VALUE ty_reserva( id_reserva = 9  aerolinea = 'IB' num_vuelo = '3950'
                              pasajero = 'Elena Martín' fecha = '20260601'
                              precio = '275.30' estado = 'A' ) INTO TABLE lt_reservas.

    INSERT VALUE ty_reserva( id_reserva = 10 aerolinea = 'LH' num_vuelo = '2030'
                              pasajero = 'Franz Weber' fecha = '20260610'
                              precio = '95.00' estado = 'A' ) INTO TABLE lt_reservas.

    LOOP AT lt_reservas INTO DATA(ls_reserva).
      out->write( |{ ls_reserva-id_reserva } | && |{ ls_reserva-aerolinea }-{ ls_reserva-num_vuelo } | &&
                  |{ ls_reserva-pasajero } | && |{ ls_reserva-precio } € | && |{ ls_reserva-estado }| ).
    ENDLOOP.

    " ===== TAREA 2.2: Modificaciones =====
    out->write( '' ).
    out->write( '===== TAREA 2.2: Modificaciones =====' ).

    " 1. Cambiar precio de la reserva ID 3
    ASSIGN lt_reservas[ id_reserva = 3 ] TO FIELD-SYMBOL(<fs_res3>).
    <fs_res3>-precio = '480.00'.

    " 2. Descuento 10% para todas las de LH
    LOOP AT lt_reservas ASSIGNING FIELD-SYMBOL(<fs_lh>) WHERE aerolinea = 'LH'.
      <fs_lh>-precio = <fs_lh>-precio * '0.9'.
    ENDLOOP.

    LOOP AT lt_reservas INTO ls_reserva WHERE id_reserva = 3 OR aerolinea = 'LH'.
      out->write( |{ ls_reserva-id_reserva } | && |{ ls_reserva-aerolinea } | && |{ ls_reserva-precio } €| ).
    ENDLOOP.

    " ===== TAREA 2.3: Cancelaciones y borrados =====
    out->write( '' ).
    out->write( '===== TAREA 2.3: Cancelaciones y borrados =====' ).

    ASSIGN lt_reservas[ id_reserva = 4 ] TO FIELD-SYMBOL(<fs_res4>).
    <fs_res4>-estado = 'C'.

    DELETE lt_reservas WHERE estado = 'C'.
    DATA(lv_borrados) = sy-dbcnt.

    LOOP AT lt_reservas INTO ls_reserva.
      out->write( |{ ls_reserva-id_reserva } | && |{ ls_reserva-aerolinea } | && |{ ls_reserva-estado }| ).
    ENDLOOP.
    out->write( |Registros eliminados: { lv_borrados }| ).

    " ===== TAREA 2.4: Búsquedas =====
    out->write( '' ).
    out->write( '===== TAREA 2.4: Busquedas =====' ).

    READ TABLE lt_reservas WITH KEY pasajero = 'Lisa Tan' TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      out->write( 'Lisa Tan tiene una reserva activa.' ).
    ELSE.
      out->write( 'Lisa Tan no tiene reserva.' ).
    ENDIF.

    DATA(lr_res6) = REF #( lt_reservas[ id_reserva = 6 ] ).
    out->write( |Reserva 6: { lr_res6->pasajero } - { lr_res6->precio } €| ).

    DATA(lv_pasajero_1) = VALUE #( lt_reservas[ id_reserva = 1 ]-pasajero OPTIONAL ).
    out->write( |Pasajero reserva 1: { lv_pasajero_1 }| ).

    " ===== TAREA 2.5: Agrupación y agregados =====
    out->write( '' ).
    out->write( '===== TAREA 2.5: Agrupacion por aerolinea =====' ).

      LOOP AT lt_reservas INTO ls_reserva
        GROUP BY ( aerolinea = ls_reserva-aerolinea )
        ASCENDING
        REFERENCE INTO DATA(lr_grupo).

      DATA(lv_num_reservas) = 0.
      DATA: lv_precio_total TYPE p LENGTH 9 DECIMALS 2.
      CLEAR lv_precio_total.

      LOOP AT GROUP lr_grupo INTO DATA(ls_miembro).
        lv_num_reservas = lv_num_reservas + 1.
        lv_precio_total = lv_precio_total + ls_miembro-precio.
      ENDLOOP.

      DATA(lv_precio_medio) = round( val = lv_precio_total / lv_num_reservas dec = 2 ).

      out->write( |{ lr_grupo->aerolinea } -> Reservas: { lv_num_reservas }, | &&
                  |Total: { lv_precio_total } €, Media: { lv_precio_medio } €| ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
