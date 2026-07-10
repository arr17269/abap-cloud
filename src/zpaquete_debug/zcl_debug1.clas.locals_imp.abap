"===================================================================
" ESQUIADOR (clase base) --> Bugs #2 y #3
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

    METHODS generar_mensaje_bienvenida
      RETURNING VALUE(rv_mensaje) TYPE string.

    METHODS get_nombre  RETURNING VALUE(rv_nombre) TYPE string.
    METHODS get_nivel   RETURNING VALUE(rv_nivel)  TYPE i.

  PROTECTED SECTION.
    DATA mv_nombre  TYPE string.
    DATA mv_nivel   TYPE i.
    DATA mv_forfait TYPE string.
ENDCLASS.

CLASS lcl_esquiador IMPLEMENTATION.

  METHOD constructor.
    mv_nombre  = iv_nombre.
    " BUG #2: el nivel se fija siempre a 1, ignorando iv_nivel.
    mv_nivel   = 1.
    mv_forfait = iv_forfait.
  ENDMETHOD.

  METHOD puede_bajar_pista.
    IF iv_color_pista = 'VERDE'.
      rv_puede = abap_true.
    ELSE.
      rv_puede = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD generar_mensaje_bienvenida.
    " BUG #3: mv_nombre y mv_forfait están intercambiados
    " dentro de la plantilla de texto.
    rv_mensaje = |Bienvenido { mv_forfait }, tu forfait es { mv_nombre }|.
  ENDMETHOD.

  METHOD get_nombre.
    rv_nombre = mv_nombre.
  ENDMETHOD.

  METHOD get_nivel.
    rv_nivel = mv_nivel.
  ENDMETHOD.

ENDCLASS.


"===================================================================
" PRINCIPIANTE --> Bug #1
"===================================================================
CLASS lcl_principiante DEFINITION INHERITING FROM lcl_esquiador.
  PUBLIC SECTION.
    METHODS puede_bajar_pista REDEFINITION.
ENDCLASS.

CLASS lcl_principiante IMPLEMENTATION.
  METHOD puede_bajar_pista.
    " Un principiante debería poder bajar VERDE y AZUL.
    " BUG #1: la condición no mira el color de pista recibido,
    " y compara mal el nivel.
    IF mv_nivel > 1.
      rv_puede = abap_true.
    ELSE.
      rv_puede = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.


"===================================================================
" MONITOR --> Bug #5
"===================================================================
CLASS lcl_monitor DEFINITION INHERITING FROM lcl_esquiador.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_nombre      TYPE string
                iv_nivel       TYPE i
                iv_forfait     TYPE string
                iv_max_alumnos TYPE i.

    METHODS asignar_alumno
      IMPORTING io_alumno TYPE REF TO lcl_esquiador.

    METHODS get_alumnos_asignados  RETURNING VALUE(rv_cantidad) TYPE i.
    METHODS get_capacidad_libre    RETURNING VALUE(rv_libre)    TYPE i.

  PRIVATE SECTION.
    DATA mv_max_alumnos     TYPE i.
    DATA mv_capacidad_libre TYPE i.
    DATA mt_alumnos         TYPE STANDARD TABLE OF REF TO lcl_esquiador WITH EMPTY KEY.
ENDCLASS.

CLASS lcl_monitor IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_nombre = iv_nombre iv_nivel = iv_nivel iv_forfait = iv_forfait ).
    mv_max_alumnos     = iv_max_alumnos.
    mv_capacidad_libre = iv_max_alumnos.
  ENDMETHOD.

  METHOD asignar_alumno.
    " BUG #5: se añade el alumno a la tabla, pero mv_capacidad_libre
    " nunca se actualiza. El estado interno queda desincronizado
    " del número real de alumnos en mt_alumnos.
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
" GRUPO DE ESQUÍ --> Bug #4
"===================================================================
CLASS lcl_grupo_esqui DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_nombre_grupo TYPE string
                io_monitor      TYPE REF TO lcl_monitor.

    METHODS sustituir_monitor
      IMPORTING io_nuevo_monitor TYPE REF TO lcl_monitor.

    METHODS get_monitor
      RETURNING VALUE(ro_monitor) TYPE REF TO lcl_monitor.

  PRIVATE SECTION.
    DATA mv_nombre_grupo TYPE string.
    DATA mo_monitor      TYPE REF TO lcl_monitor.
ENDCLASS.

CLASS lcl_grupo_esqui IMPLEMENTATION.

  METHOD constructor.
    mv_nombre_grupo = iv_nombre_grupo.
    mo_monitor      = io_monitor.
  ENDMETHOD.

  METHOD sustituir_monitor.
    " BUG #4: se reasigna una variable local en vez del atributo
    " mo_monitor. El llamador cree que ha cambiado el monitor del
    " grupo, pero mo_monitor sigue apuntando al de antes.
    DATA(lo_monitor_temporal) = io_nuevo_monitor.
    lo_monitor_temporal = mo_monitor.
  ENDMETHOD.

  METHOD get_monitor.
    ro_monitor = mo_monitor.
  ENDMETHOD.

ENDCLASS.

