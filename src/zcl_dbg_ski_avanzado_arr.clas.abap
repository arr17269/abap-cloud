CLASS zcl_dbg_ski_avanzado_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dbg_ski_avanzado_arr IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_juan)   = NEW lcl_principiante( iv_nombre = 'Juan' iv_nivel = 1 iv_forfait = 'F-1001' ).
    DATA(lo_ana)    = NEW lcl_federado( iv_nombre = 'Ana' iv_nivel = 3 iv_forfait = 'F-1002' iv_club = 'CLUB-GR' ).
    DATA(lo_sergio) = NEW lcl_monitor( iv_nombre = 'Sergio' iv_nivel = 3 iv_forfait = 'F-1003' iv_max_alumnos = 4 ).
    out->write( lo_juan->generar_mensaje_bienvenida( ) ).
    out->write( |¿Ana es del club 7?: { lo_ana->es_del_club( 'CLUB-GR' ) }| ).

    out->write( |Juan puede VERDE: { lo_juan->puede_bajar_pista( 'VERDE' ) }| ).
    out->write( |Sergio puede NEGRA: { lo_sergio->puede_bajar_pista( 'NEGRA' ) }| ).
    out->write( |Nivel de Ana: { lo_ana->obtener_descripcion_nivel( ) }| ).
    out->write( lo_juan->generar_mensaje_bienvenida( ) ).

    DATA(lo_pista_verde) = NEW lcl_pista( iv_nombre = 'Borreguiles' iv_color = 'VERDE' iv_aforo_max = 2 ).

    DATA(lo_grupo) = NEW lcl_grupo_esqui( iv_nombre_grupo = 'Grupo Granada' io_monitor = lo_sergio ).
    lo_grupo->anadir_esquiador( lo_juan ).
    lo_grupo->anadir_esquiador( lo_ana ).
    lo_grupo->intentar_entrar_todos( lo_pista_verde ).

    out->write( |Ocupación pista verde: { lo_pista_verde->get_ocupacion_actual( ) }| ).

    lo_sergio->asignar_alumno( lo_juan ).
    out->write( |Alumnos asignados a Sergio: { lo_sergio->get_alumnos_asignados( ) } | &&
                |(capacidad libre: { lo_sergio->get_capacidad_libre( ) })| ).


    DATA(lo_nuevo_monitor) = NEW lcl_monitor( iv_nombre = 'Elena' iv_nivel = 3 iv_forfait = 'F-9999' iv_max_alumnos = 4 ).
    lo_grupo->sustituir_monitor( lo_nuevo_monitor ).
    out->write( |Monitor del grupo tras sustituir: { lo_grupo->get_monitor( )->get_nombre( ) }| ).


    DATA(lo_equipo) = NEW lcl_equipo_alquiler( ).
    DATA(lt_stock_pista) = VALUE lcl_equipo_alquiler=>tt_stock( ( `GAFAS` ) ).
    lo_equipo->cargar_stock_inicial( CHANGING ct_stock = lt_stock_pista ).
    out->write( |Stock pista tras cargar inicial: { lines( lt_stock_pista ) } items| ).

    DATA(lo_grupo_2) = NEW lcl_grupo_esqui( iv_nombre_grupo = 'Grupo Sevilla' io_monitor = lo_sergio ).
    lo_grupo_2->get_monitor( )->asignar_alumno( lo_ana ).
    out->write( |Alumnos de Sergio tras tocar el grupo 2: { lo_grupo->get_monitor( )->get_alumnos_asignados( ) }| ).
    " ^ Aunque solo hemos tocado lo_grupo_2, el monitor de lo_grupo
    "   también se ve afectado. ¿Por qué?


    DATA(lo_pista_cerrada) = NEW lcl_pista( iv_nombre = 'Pista en mantenimiento' iv_color = 'ROJA' iv_aforo_max = 0 ).
    TRY.
        DATA(lv_porcentaje) = lo_pista_cerrada->get_porcentaje_ocupacion( ).
        out->write( |Ocupación pista cerrada: { lv_porcentaje }%| ).
      CATCH cx_root INTO DATA(lx_zero).
        out->write( |Error al calcular ocupación: { lx_zero->get_text( ) }| ).
    ENDTRY.


    TRY.
        DATA(lv_minutos) = lo_grupo->calcular_tiempo_ruta( 3 ).
        out->write( |Tiempo de ruta: { lv_minutos } min| ).
      CATCH cx_root INTO DATA(lx_error).
        out->write( |Error en cálculo de ruta: { lx_error->get_text( ) }| ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
