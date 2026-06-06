CLASS zcl_listadoid_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_listadoid_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    out->write( 'Crear tipos y tabla de alumnos' ).
    out->write( | | ).
    out->write( | | ).
    TYPES: BEGIN OF ty_alumnos,
             id     TYPE n  LENGTH 4,
             nombre TYPE string,
           END OF TY_alumnos.

    DATA ls_alumnos TYPE ty_alumnos.
    DATA lt_alumnos TYPE table of ty_alumnos.
    DATA lv_id type i.

    lt_alumnos = VALUE #(

      LET v = 0 IN ( id = v + 1    nombre = 'antonia' )
                   ( id = v + 2    nombre = 'luis' )
                   ( id = v + 3    nombre = 'carlos' )
                   ( id = v + 4    nombre = 'paco' )
                   ( id = v + 5    nombre = 'gabriel' )
                   ( id = v + 6    nombre = 'alejandro' )
                   ( id = v + 7    nombre = 'samuel' )
                   ( id = v + 8    nombre = 'adrian' )
                   ( id = v + 9    nombre = 'ivan' )
                   ( id = v + 10   nombre = 'rosa' )
                   ( id = v + 11   nombre = 'lidia' )
                   ( id = v + 12   nombre = 'antonio' )
                   ( id = v + 13   nombre = 'felipe' )
                   ( id = v + 14   nombre = 'sara' )
                   ( id = v + 15   nombre = 'belen' )
                   ( id = v + 16   nombre = 'rosana' )

                    ).
    out->write( lt_alumnos ).

    DATA(lv_total_alumnos) = lines( lt_alumnos ).
    DATA(lv_random) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                           min = 1
                                                           max = lv_total_alumnos ).


" -----------------------------------------------------------------
    " PASO 1: CREAR UNA TABLA INTERNA PARA GUARDAR LOS NÚMEROS DEL SORTEO
    " -----------------------------------------------------------------
    " Necesitamos una estructura simple para ir anotando los IDs que salgan
    TYPES: BEGIN OF ty_sorteo,
             id_premiado TYPE n LENGTH 4,
           END OF ty_sorteo.

    DATA lt_historial_sorteo TYPE TABLE OF ty_sorteo.

    " -----------------------------------------------------------------
    " PASO 2: HACER EL SORTEO (EXTRAER 20 NÚMEROS ALEATORIOS)
    " -----------------------------------------------------------------
    " Vamos a hacer que la máquina "saque" un número 20 veces seguidas
    DO 20 TIMES.
      " Extraemos el número aleatorio real usando ->get_next()
      DATA(lv_id_ganador) = lv_random->get_next( ).

      " Guardamos ese número en nuestra tabla de historial
      APPEND VALUE #( id_premiado = lv_id_ganador ) TO lt_historial_sorteo.
    ENDDO.

    " Imprimimos el historial en la consola para ver qué números salieron
    out->write( | | ).
    out->write( '--- HISTORIAL DE IDS QUE SALIERON EN EL SORTEO ---' ).
    out->write( lt_historial_sorteo ).

    " -----------------------------------------------------------------
    " PASO 3: CONTAR CUÁL ID SALIÓ MÁS VECES
    " -----------------------------------------------------------------
    " Estructura para consolidar: "El ID X salió Y veces"
    TYPES: BEGIN OF ty_conteo,
             id    TYPE n LENGTH 4,
             veces TYPE i,
           END OF ty_conteo.
    DATA lt_conteos TYPE TABLE OF ty_conteo.

    " Agrupamos los IDs iguales del historial para contarlos
    LOOP AT lt_historial_sorteo INTO DATA(ls_ronda)
      GROUP BY ls_ronda-id_premiado INTO DATA(lv_id_grupo).

      DATA(lv_acumulador) = 0.
      LOOP AT GROUP lv_id_grupo INTO DATA(ls_miembro).
        lv_acumulador = lv_acumulador + 1.
      ENDLOOP.

      APPEND VALUE #( id = lv_id_grupo veces = lv_acumulador ) TO lt_conteos.
    ENDLOOP.

    " Ordenamos la tabla de mayor a menor según las 'veces'
    SORT lt_conteos BY veces DESCENDING.

    " -----------------------------------------------------------------
    " PASO 4: VER EL NOMBRE DEL GANADOR DE LAS CHUCHES
    " -----------------------------------------------------------------
    " Al ordenar de mayor a menor, la fila 1 es el que más veces salió
    READ TABLE lt_conteos INTO DATA(ls_max_ganador) INDEX 1.

    IF sy-subrc = 0.
      " Buscamos el nombre de esa persona en tu tabla original 'lt_alumnos'
      READ TABLE lt_alumnos INTO DATA(ls_alumno_premiado)
        WITH KEY id = ls_max_ganador-id.

      " ¡Mostramos el gran resultado final por la consola!
      out->write( | | ).
      out->write( '===================================================' ).
      out->write( |¡EL GANADOR DE LA BOLSA DE CHUCHES ES!| ).
      out->write( |Nombre: { ls_alumno_premiado-nombre }| ).
      out->write( |ID Alumno: { ls_max_ganador-id }| ).
      out->write( |¿Cuántas veces salió su número?: { ls_max_ganador-veces } veces.| ).
      out->write( '===================================================' ).
    ENDIF.


" =================================================================
    " NUEVO EJERCICIO: AÑADIR UN REGISTRO NUEVO DE UNO EN UNO
    " =================================================================

    " 1. Almacenamos el nuevo nombre en una variable normal (como pide el enunciado)
    DATA lv_nuevo_nombre TYPE string VALUE 'Daniel Rosendo Elvira Ruiz'.

    " 2. Averiguamos de forma automática el último ID para calcular el siguiente consecutivo.
    " Contamos cuántos alumnos hay actualmente (hay 16, por lo tanto el próximo ID debe ser 17)
    DATA(lv_ultimo_indice) = lines( lt_alumnos ).
    DATA(lv_siguiente_id)  = lv_ultimo_indice + 1.

    " 3. Preparamos el registro nuevo en nuestra variable de estructura (ls_alumnos)
    ls_alumnos-id     = lv_siguiente_id. " Tomará automáticamente el valor 0017
    ls_alumnos-nombre = lv_nuevo_nombre.

    " 4. Insertamos el nuevo alumno de uno en uno al final de nuestra tabla interna
    APPEND ls_alumnos TO lt_alumnos.

    " 5. Imprimimos un mensaje de confirmación y la tabla actualizada para comprobarlo
    out->write( | | ).
    out->write( '--- ¡ALUMNO NUEVO AÑADIDO DE UNO EN UNO! ---' ).
    out->write( |Se ha registrado a: { lv_nuevo_nombre } con el ID automático: { ls_alumnos-id }| ).
    out->write( | | ).
    out->write( '--- LISTA DE ALUMNOS ACTUALIZADA CON 17 MIEMBROS ---' ).
    out->write( lt_alumnos ).

    " =================================================================
    " A partir de aquí continúa tu lógica del SOTEOR DE CHUCHES...
    " (Como ahora 'lines( lt_alumnos )' detectará 17 filas automáticamente,
    " Daniel también entrará en el sorteo aleatorio sin tocar nada más)
    " =================================================================
    DATA(lv_total_alumnos1) = lines( lt_alumnos ). " Ahora valdrá 17 dinámicamente








  ENDMETHOD.
ENDCLASS.
