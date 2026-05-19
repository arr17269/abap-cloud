CLASS zc_tipos_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZC_TIPOS_ARR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


*data lv_nombre type string.
*      lv_nombre = 'Pepe'.
*
*
*data lv_string type string.
*
*
*lv_nombre = 'hola'.

*ejercicio 1

TYPES: BEGIN OF ty_tabla,
            nombre type string,
            edad type i,
            domicilio TYPE string,
            email type string,
       END OF ty_tabla.

 DATA ls_tabla TYPE ty_tabla.
 data lt_tabla type table of ty_tabla.

"agregar datos de forma moderna

out->write( |Ejercicio 1. Insertar registros de forma moderna.| ).
out->write( | | ).
out->write( |Tabla| ).
out->write( | | ).
        lt_tabla = value #(
                    ( nombre = 'Ana'    edad = 23 domicilio = 'C/Jardines'     email = 'nose@gmail.com' )
                    ( nombre = 'Luis'   edad = 25 domicilio = 'C/Madrigales'   email = 'nose@gmail.com' )
                    ( nombre = 'Andres' edad = 35 domicilio = 'Callejón Angel' email = 'nose@gmail.com' )
                    ( nombre = 'Pedro'  edad = 30 domicilio = 'Paseo Jardines' email = 'nose@gmail.com' )
                            ).

out->write( lt_tabla ).

"copiar a otra tabla LIKE.
out->write( | | ).
out->write( 'Ejercicio 2. Copiar tabla con LIKE' ).
out->write( | | ).

DATA lt_cliente LIKE lt_tabla.
DATA lt_tabla1 LIKE lt_tabla.
out->write( lt_cliente ).

"insertar registros de la tabla "tabla" en la tabla "cliente".

out->write( | | ).
out->write( 'Ejercicio 3. Copiar registros de la tabla "tabla" a la tabla "cliente" ' ).
out->write( | | ).

INSERT LINES OF lt_tabla INTO TABLE lt_cliente.

out->write( lt_cliente ).
"ejercicio 4. Insertar linea en blanco en el registro 2.

out->write( | | ).
out->write( 'Ejercicio 4. Insertar linea en blanco en el segundo registro" ' ).
out->write( | | ).

INSERT INITIAL LINE INTO lt_cliente index 2.
out->write( | | ).
out->write( 'Tabla Cliente ' ).
out->write( lt_cliente ).

out->write( | | ).
out->write( 'Ejercicio 5. Insertar un registro con APPEND' ).
out->write( | | ).

APPEND VALUE #( nombre = 'Luisa' edad = 42 domicilio = 'C/Barranco del burro' email = 'burrito@gmail.com' ) to lt_cliente.
out->write( lt_cliente ).

out->write( | | ).
out->write( 'Ejercicio 6. Contador de registro máximo" ' )."cuenta la linea en blanco.
out->write( | | ).

data(lv_registros) = lines( lt_cliente ).
out->write( lv_registros ).

out->write( | | ).
out->write( 'Ejercicio 7.RANDOM ' ).
out->write( | | ).

data lv_contador type i VALUE 0.

  data(lv_random) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                       min = 1
                                                       max = lv_registros ).

  DATA(lv_min) = lv_random->get_next(  ).
  DATA(lv_max) = lv_random->get_next(  ).
  "comprobacion de minimo y maximo.
  If lv_min > lv_max.
        DATA(lv_aux) = lv_min.
            lv_min = lv_max.
            lv_max = lv_min.
  Endif.

  insert lines of lt_cliente from lv_min to lv_max into table lt_tabla1.

    out->write( 'Tabla 1' ).
    out->write( lt_tabla1 ).

  ENDMETHOD.
ENDCLASS.
