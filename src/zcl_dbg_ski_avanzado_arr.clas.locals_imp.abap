"===================================================================
" EXCEPCIONES
"===================================================================
CLASS lcx_pista_no_apta DEFINITION INHERITING FROM cx_static_check FINAL.
  PUBLIC SECTION.
    DATA mv_color_pista TYPE string.
    METHODS constructor
      IMPORTING iv_color_pista TYPE string OPTIONAL
                previous       LIKE previous OPTIONAL.
ENDCLASS.

CLASS lcx_pista_no_apta IMPLEMENTATION.
  METHOD constructor.
    super->constructor( previous = previous ).
    mv_color_pista = iv_color_pista.
  ENDMETHOD.
ENDCLASS.

CLASS lcx_aforo_completo DEFINITION INHERITING FROM cx_static_check FINAL.
  PUBLIC SECTION.
    DATA mv_pista TYPE string.
    METHODS constructor
      IMPORTING iv_pista TYPE string OPTIONAL
                previous LIKE previous OPTIONAL.
ENDCLASS.

CLASS lcx_aforo_completo IMPLEMENTATION.
  METHOD constructor.
    super->constructor( previous = previous ).
    mv_pista = iv_pista.
  ENDMETHOD.
ENDCLASS.

CLASS lcx_equipo_incompleto DEFINITION INHERITING FROM cx_static_check FINAL.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING previous LIKE previous OPTIONAL.
ENDCLASS.

CLASS lcx_equipo_incompleto IMPLEMENTATION.
  METHOD constructor.
    super->constructor( previous = previous ).
  ENDMETHOD.
ENDCLASS.


"===================================================================
" ESQUIADOR (base) --> Bugs Nivel 1: #2, #3, #4
"===================================================================
CLASS lcl_esquiador DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_nombre  TYPE string
                iv_nivel   TYPE i
                iv_forfait TYPE string.

    METHODS puede_bajar_pista
      IMPORTING iv_color_pista  TYPE string
      RETURNING VALUE(rv_puede) TYPE abap_bool.

    METHODS obtener_descripcion_nivel
      RETURNING VALUE(rv_descripcion) TYPE string.

    METHODS generar_mensaje_bienvenida
      RETURNING VALUE(rv_mensaje) TYPE string.

    METHODS get_nombre   RETURNING VALUE(rv_nombre) TYPE string.
    METHODS get_nivel    RETURNING VALUE(rv_nivel)  TYPE i.

  PROTECTED SECTION.
    DATA mv_nombre  TYPE string.
    DATA mv_nivel   TYPE i.
    DATA mv_forfait TYPE string.
ENDCLASS.

CLASS lcl_esquiador IMPLEMENTATION.

  METHOD constructor.
    mv_nombre  = iv_nombre.
    mv_nivel   = iv_nivel.
    mv_forfait = iv_forfait.
  ENDMETHOD.

  METHOD puede_bajar_pista.
    rv_puede = xsdbool( iv_color_pista = 'VERDE' ).
  ENDMETHOD.

  METHOD obtener_descripcion_nivel.

    CASE mv_nivel.
      WHEN 1.
        rv_descripcion = 'Principiante'.
      WHEN 2.
        rv_descripcion = 'Intermedio'.
      WHEN 3.
        rv_descripcion = 'Avanzado'.
    ENDCASE.
  ENDMETHOD.

  METHOD generar_mensaje_bienvenida.
    rv_mensaje = |Bienvenido { mv_nombre }, tu forfait es { mv_forfait }|.
  ENDMETHOD.

  METHOD get_nombre.
    rv_nombre = mv_nombre.
  ENDMETHOD.

  METHOD get_nivel.
    rv_nivel = mv_nivel.
  ENDMETHOD.

ENDCLASS.


"===================================================================
" PRINCIPIANTE --> Bug Nivel 1: #1
"===================================================================
CLASS lcl_principiante DEFINITION INHERITING FROM lcl_esquiador.
  PUBLIC SECTION.
    METHODS puede_bajar_pista REDEFINITION.
ENDCLASS.

CLASS lcl_principiante IMPLEMENTATION.
  METHOD puede_bajar_pista.

    rv_puede = xsdbool( mv_nivel > 1 ).
  ENDMETHOD.
ENDCLASS.


"===================================================================
" FEDERADO --> Bug Nivel 2: #8
"===================================================================
CLASS lcl_federado DEFINITION INHERITING FROM lcl_esquiador.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_nombre  TYPE string
                iv_nivel   TYPE i
                iv_forfait TYPE string
                iv_club    TYPE string.

    METHODS puede_bajar_pista REDEFINITION.

    METHODS es_del_club
      IMPORTING iv_club_buscado TYPE string
      RETURNING VALUE(rv_es)    TYPE abap_bool.

  PRIVATE SECTION.
    DATA mv_club TYPE string.
ENDCLASS.

CLASS lcl_federado IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_nombre = iv_nombre iv_nivel = iv_nivel iv_forfait = iv_forfait ).
    mv_club = iv_club.
  ENDMETHOD.

  METHOD puede_bajar_pista.
    rv_puede = abap_true.
  ENDMETHOD.

  METHOD es_del_club.

    rv_es = xsdbool( mv_club = iv_club_buscado ).
  ENDMETHOD.

ENDCLASS.


"===================================================================
" MONITOR --> Bugs: #5 (N2), #11 (N3), #13 (N4)
"===================================================================
CLASS lcl_monitor DEFINITION INHERITING FROM lcl_esquiador.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_nombre      TYPE string
                iv_nivel       TYPE i
                iv_forfait     TYPE string
                iv_max_alumnos TYPE i.

    METHODS puede_bajar_pista REDEFINITION.

    METHODS asignar_alumno
      IMPORTING io_alumno TYPE REF TO lcl_esquiador.

    METHODS get_alumnos_asignados   RETURNING VALUE(rv_cantidad) TYPE i.
    METHODS get_capacidad_libre     RETURNING VALUE(rv_libre)    TYPE i.

  PRIVATE SECTION.
    DATA mv_max_alumnos     TYPE i.
    DATA mv_capacidad_libre TYPE i.
    DATA mt_alumnos         TYPE STANDARD TABLE OF REF TO lcl_esquiador WITH EMPTY KEY.
ENDCLASS.

CLASS lcl_monitor IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_nombre = iv_nombre iv_nivel = iv_nivel iv_forfait = iv_forfait ).
    mv_capacidad_libre = mv_max_alumnos.
    mv_max_alumnos = iv_max_alumnos.
  ENDMETHOD.

  METHOD puede_bajar_pista.

    rv_puede = super->puede_bajar_pista( iv_color_pista ).
  ENDMETHOD.

  METHOD asignar_alumno.

    APPEND io_alumno TO mt_alumnos.
  ENDMETHOD.

  METHOD get_alumnos_asignados.
    rv_cantidad = lines( mt_alumnos ).
  ENDMETHOD.

  METHOD get_capacidad_libre.
    rv_libre = mv_capacidad_libre.
  ENDMETHOD.

ENDCLASS.


"===================================================================
" PISTA --> Bugs: #7 (N2), #10 (N3), #14 (N4)
"===================================================================
CLASS lcl_pista DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_ocupante,
             forfait TYPE string,
           END OF ty_ocupante.
    TYPES tt_ocupantes TYPE STANDARD TABLE OF ty_ocupante WITH EMPTY KEY.

    METHODS constructor
      IMPORTING iv_nombre    TYPE string
                iv_color     TYPE string
                iv_aforo_max TYPE i.

    METHODS entrar_pista
      IMPORTING io_esquiador TYPE REF TO lcl_esquiador
      RAISING   lcx_pista_no_apta lcx_aforo_completo.

    METHODS salir_pista
      IMPORTING iv_forfait TYPE string.

    METHODS eliminar_ocupantes_de_forfait
      IMPORTING iv_forfait TYPE string.

    METHODS get_ocupacion_actual
      RETURNING VALUE(rv_ocupacion) TYPE i.

    METHODS get_porcentaje_ocupacion
      RETURNING VALUE(rv_porcentaje) TYPE i.

  PRIVATE SECTION.
    DATA mv_nombre    TYPE string.
    DATA mv_color     TYPE string.
    DATA mv_aforo_max TYPE i.
    DATA mv_ocupacion TYPE i.
    DATA mt_ocupantes TYPE tt_ocupantes.
ENDCLASS.

CLASS lcl_pista IMPLEMENTATION.

  METHOD constructor.
    mv_nombre    = iv_nombre.
    mv_color     = iv_color.
    mv_aforo_max = iv_aforo_max.
  ENDMETHOD.

  METHOD entrar_pista.
    IF io_esquiador->puede_bajar_pista( mv_color ) = abap_false.
      RAISE EXCEPTION TYPE lcx_pista_no_apta EXPORTING iv_color_pista = mv_color.
    ENDIF.

    IF mv_ocupacion >= mv_aforo_max.
      RAISE EXCEPTION TYPE lcx_aforo_completo EXPORTING iv_pista = mv_nombre.
    ENDIF.

    APPEND VALUE #( forfait = io_esquiador->get_nombre( ) ) TO mt_ocupantes.
    mv_ocupacion = mv_ocupacion + 1.
  ENDMETHOD.

  METHOD salir_pista.

    READ TABLE mt_ocupantes WITH KEY forfait = iv_forfait TRANSPORTING NO FIELDS.

    DELETE mt_ocupantes WHERE forfait = iv_forfait.
    mv_ocupacion = mv_ocupacion - 1.
  ENDMETHOD.

  METHOD eliminar_ocupantes_de_forfait.

    LOOP AT mt_ocupantes INTO DATA(ls_ocupante).
      IF ls_ocupante-forfait = iv_forfait.
        DELETE mt_ocupantes WHERE forfait = iv_forfait.
        mv_ocupacion = mv_ocupacion - 1.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_ocupacion_actual.
    rv_ocupacion = mv_ocupacion.
  ENDMETHOD.

  METHOD get_porcentaje_ocupacion.

    rv_porcentaje = ( mv_ocupacion * 100 ) / mv_aforo_max.
  ENDMETHOD.

ENDCLASS.


"===================================================================
" EQUIPO DE ALQUILER --> Bug Nivel 3: #12
"===================================================================
CLASS lcl_equipo_alquiler DEFINITION.
  PUBLIC SECTION.
    TYPES tt_stock TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    METHODS constructor.

    METHODS cargar_stock_inicial
      CHANGING ct_stock TYPE tt_stock.

    METHODS reservar_material
      IMPORTING iv_tipo TYPE string.

    METHODS get_stock
      RETURNING VALUE(rt_stock) TYPE tt_stock.

  PRIVATE SECTION.
    DATA mt_stock TYPE tt_stock.
ENDCLASS.

CLASS lcl_equipo_alquiler IMPLEMENTATION.

  METHOD constructor.
    mt_stock = VALUE #( ( `ESQUIS` ) ( `BOTAS` ) ( `CASCO` ) ).
  ENDMETHOD.

  METHOD cargar_stock_inicial.

    APPEND `PALOS` TO ct_stock.
    mt_stock = ct_stock.
  ENDMETHOD.

  METHOD reservar_material.
    DELETE mt_stock WHERE table_line = iv_tipo.
  ENDMETHOD.

  METHOD get_stock.
    rt_stock = mt_stock.
  ENDMETHOD.

ENDCLASS.


"===================================================================
" GRUPO DE ESQUÍ --> Bugs: #6 (N2), #9 (N3), #15 (N4), #16 (N4)
"===================================================================
CLASS lcl_grupo_esqui DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_nombre_grupo TYPE string
                io_monitor      TYPE REF TO lcl_monitor.

    METHODS anadir_esquiador
      IMPORTING io_esquiador TYPE REF TO lcl_esquiador.

    METHODS intentar_entrar_todos
      IMPORTING io_pista TYPE REF TO lcl_pista.

    METHODS sustituir_monitor
      IMPORTING io_nuevo_monitor TYPE REF TO lcl_monitor.

    METHODS get_monitor
      RETURNING VALUE(ro_monitor) TYPE REF TO lcl_monitor.

    METHODS calcular_tiempo_ruta
      IMPORTING iv_tramos_restantes TYPE i
      RETURNING VALUE(rv_minutos)   TYPE i.

  PRIVATE SECTION.
    DATA mv_nombre_grupo TYPE string.
    DATA mt_esquiadores  TYPE STANDARD TABLE OF REF TO lcl_esquiador WITH EMPTY KEY.
    DATA mo_monitor      TYPE REF TO lcl_monitor.
ENDCLASS.

CLASS lcl_grupo_esqui IMPLEMENTATION.

  METHOD constructor.
    mv_nombre_grupo = iv_nombre_grupo.
    mo_monitor      = io_monitor.
  ENDMETHOD.

  METHOD anadir_esquiador.
    APPEND io_esquiador TO mt_esquiadores.
  ENDMETHOD.

  METHOD intentar_entrar_todos.
    LOOP AT mt_esquiadores INTO DATA(lo_esquiador).
      TRY.
          io_pista->entrar_pista( lo_esquiador ).

        CATCH lcx_pista_no_apta.

        CATCH lcx_aforo_completo.
          " no hacer nada
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

  METHOD sustituir_monitor.

    DATA(lo_monitor_temporal) = io_nuevo_monitor.
    lo_monitor_temporal = mo_monitor.
  ENDMETHOD.

  METHOD get_monitor.
    ro_monitor = mo_monitor.
  ENDMETHOD.

  METHOD calcular_tiempo_ruta.

    IF iv_tramos_restantes <= 0.
      rv_minutos = 0.
    ELSE.
      rv_minutos = 5 + calcular_tiempo_ruta( iv_tramos_restantes - 1 ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
