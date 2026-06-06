CLASS zcl_id_alumnos_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_id_alumnos_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( |--- LISTADO DE ALUMNOS ---| ).
    out->write( | | ).


  TYPES: BEGIN OF ty_alumnos,
         ID TYPE n LENGTH 4,
         nombre type string,
         END OF TY_alumnos.


   data lt_alumnos type table of ty_alumnos.
   DATA ls_alumnos type ty_alumnos.
   DATA lv_id type i.





    lt_alumnos = value #(
  LET v = 0 IN  ( id = v + 1      nombre = 'CARRILLO LOPERA, IRENE' )
                ( id = v + 2      nombre = 'MALDONADO HERNANDEZ, LUIS' )
                ( id = v + 3      nombre = 'MORENO CABRERA, MARIA DOLORES' )
                ( id = v + 4      nombre = 'PALACIOS CANALES, REBECA' )
                ( id = v + 5      nombre = 'TORRES ALBILLO, ADRIAN' )
                ( id = v + 6      nombre = 'CONTRERAS CANO, JAVIER' )
                ( id = v + 7      nombre = 'MARTÍN MONTORO, ANTONIO'  )
                ( id = v + 8      nombre = 'ARAQUE CONTRERAS, JIMMY ENRIQUE')
                ( id = v + 9      nombre = 'BUREO OSUNA, JESUS' )
                ( id = v + 10     nombre = 'CRIADO ROMERO, SAMUEL' )
                ( id = v + 11     nombre = 'PRADOS HARO, ALEJANDRO' )
                ( id = v + 11     nombre = 'GONZALEZ RAMIREZ, ALBERTO' )
                ( id = v + 12     nombre = 'RUIZ RODRIGUEZ, ANTONIA' )
                ( id = v + 13     nombre = 'PORTILLO MORAL, GONZALO' )

                                    ).

     data(lv_total_alumnos) = lines( lt_alumnos ).
     data(lv_random) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                       min = 1
                                                        max = lv_total_alumnos ).


       out->write( lt_alumnos ).



"-----------------------------------------------------
"crear una tabla simple para guardar los IDs del sorteo
"-----------------------------------------------------
TYPES:BEGIN OF ty_sorteo,
      id_sorteo type n length 4,
      END OF TY_sorteo.

      DATA lt_historial_sorteo type TABLE OF ty_sorteo.
"----------------------------------------------------
  "hacer el sorteo (extraer 20 numeros aleatorios)
"----------------------------------------------------
  DO 20 TIMES.

  data(lv_id_premiado) = lv_random->get_next( ).   "variable para almacenar los Ids premiados

    APPEND VALUE #( id_sorteo = lv_id_premiado ) to lt_historial_sorteo.
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
      GROUP BY ls_ronda-id_sorteo INTO DATA(lv_id_grupo).

      DATA(lv_acumulador) = 0.
      LOOP AT GROUP lv_id_grupo INTO DATA(ls_miembro).
        lv_acumulador = lv_acumulador + 1.
      ENDLOOP.

      APPEND VALUE #( id = lv_id_grupo veces = lv_acumulador ) TO lt_conteos.
    ENDLOOP.

    " Ordenamos la tabla de mayor a menor según las 'veces'
    SORT lt_conteos BY veces DESCENDING.







  ENDMETHOD.
ENDCLASS.
