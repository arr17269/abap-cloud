CLASS zcl_cargadatos_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cargadatos_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*
*  delete from zcl_DATABASE_ARR.
*
*   MODIFY zcl_database_arr FROM TABLE @(
*          value #(
*
*          ( client = '100'
*            correo = 'toniarr@gmail.com'
*            nombre = 'antonia'
*            edad = '25'
*            telefono = '858962' )
*
*            ( client = '100'
*                correo = 'luis@yahoo.es'
*                nombre = 'luis'
*                edad = '34'
*                telefono = '254367' )
*
*            ( client = '100'
*                correo = 'romeral@gmail.com'
*                nombre = 'flipado'
*                edad = 17
*                telefono = '254659' )
*           )
*           ).



      SELECT FROM zcl_database_arr
      FIELDS *
      into table @data(lt_cliente).

      if sy-subrc = 0.

      read table lt_cliente into data(ls_cliente) with key correo = 'luis@yahoo.es'.
      data(lv_index) = sy-tabix. "sy-tabix refleja el indice

      ENDIF.

            out->write( lt_cliente ).
            out->write( | El indice en la tabla interna es: { sy-tabix }| ).  "{} cuidado con los espacios

       out->write( | | ).
       out->write( 'Ejercicio 3. Mostrar filas totales de la tabla' ).
       out->write( lines( lt_cliente ) ).


      select from zcl_database_arr
      fields *
      into table @data(lt_modificar).

    LOOP AT lt_modificar into data(ls_modificar).
        if ls_modificar-edad > 18.
      data(lv_longitud) = strlen( ls_modificar-nombre ).

      if lv_longitud > 0.
         ls_modificar-nombre = substring( val = ls_modificar-nombre
                                        off = 0
                                        len = lv_longitud - 1 ) && 's'.
      ENDIF.
        MODIFY lt_modificar from ls_modificar.

  endif.
      ENDLOOP.

      modify zcl_database_arr from table @lt_modificar.

"delete lt_modificar from 2 to 4. "borra de la fila 2 hasta la 4
"delete lt_mofificar index 2.
"delete lt_modificar where nombre is INITIAL
"delete ADJACENT DUPLICATES FROM lt_mofificar COMPARING nombre.



           out->write( | | ).
           out->write( 'Ejercicio 4. Modificar la ultima letra del nombre por una S' ).
           out->write( lt_modificar ).











  ENDMETHOD.
ENDCLASS.
