CLASS zcl_tablas2_arr2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tablas2_arr2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  select from /dmo/airport
*  fields *                          "todos los campos.
*  where country EQ 'DE'              "EQ es igual.
*  into table @data(lt_flights).      "los pega a una tabla interna.

*  if sy-subrc = 0.                   "si se ha ejecutado correctamente.
*
*  out->write( lt_flights ).
*  ENDIF.
*
*  "se utiliza para leer una linea interna en tiempo de ejecución y nos permite buscar datos de forma eficiente.
*
*  READ table lt_flights into data(ls_flight) index 1. "trae una linea concreta con los registros de la tabla de la base de datos.
*
*  out->write( ls_flight ).
*
*
*  read table lt_flights into data(ls_flight2) index 2 TRANSPORTING airport_id city.
*  out->write( ls_flight2 ).

*  if sy-subrc = 0.
*
*  read table lt_flights into data(ls_flight) with key city = 'Berlin'.
*  out->write( ls_flight ).
*
*  data(ls_flight2) = lt_flights[ city = 'Berlin' ]-city.
*  out->write( ls_flight ).

"PRIMARY KEY. para tablas sort y hash.

*DATA lt_flight_sort TYPE SORTED table of /dmo/airport with NON-UNIQUE key airport_id. "la tabla sort necesita una clave unique o non-unique.
*select from /dmo/airport
*fields *
*into table @lt_flight_sort. "aqui no se pone @data porque ya hemos declarado la tabla.
*
*read table lt_flight_sort into data(ls_flight) WITH table key airport_id = 'LAS'.
*out->write( ls_flight ).
*
*data(ls_flight2) = lt_flight_sort[ key primary_key airport_id = 'LAS' ].
*out->write( ls_flight ).
""""""""""""""""""""""""""""""""""""""""""""
Out->write( | | ).
Out->write( 'Ejercicio de Extraer de una BD' ).
Out->write( | | ).
Out->write( |Ejercicio 1. Extrae todos los registros de la BD dmo/airport| ).
Out->write( | | ).
"extrae para la tabla de BD /dmo/airport, todos los registros del campo country = UK
"extrae unicamente el campo nombre que esta asociado a LGW del cmapo airport_id
"extrae con la tabla SORTED todos los registros donde country sea igual a IT.

select from /dmo/airport
fields *
where country EQ 'UK'
into table @data(lt_copia).

Out->write( lt_copia  ).

Out->write( | | ).
Out->write( |Ejercicio 2. Extrae unicamente el campo nombre asociado a campo airpor_id = LGW| ).
Out->write( | | ).

select  from /dmo/airport
fields *
where airport_id EQ 'LGW'
into table @data(lt_copia2).

Out->write( lt_copia2  ).

Out->write( | | ).

Out->write( | | ).
Out->write( |Ejercicio 3. Extrae con la tabla sorted todos los registros donde country sea igual a IT| ).
Out->write( | | ).

DATA lt_flight_sort type sorted table of /dmo/airport with non-unique key airport_id.
select from /dmo/airport
fields *
where country = 'IT'
into table @lt_flight_sort.

out->write( lt_flight_sort ).







  ENDMETHOD.
ENDCLASS.
