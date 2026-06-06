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



  delete from zcl_database_arr.
  MODIFY zcl_database_arr from table @(
           value #(

           ( client = '100'
           correo = 'toniarr@gmail.com'
           edad = '25'
           nombre = 'antonia'
           telefono = '858962' )
           ( client = '100'
           correo = 'leonardo@yahoo.es'
           edad = '35'
           nombre = 'leonardo'
           telefono = '568475' )
           ( client = '100'
           correo = 'romeral@gmail.ccom'
           edad = '24'
           nombre = 'romero'
           telefono = '247584' )
           ( client = '100'
            correo = 'melon@gmail.com'
            edad = '19'
            telefono = '127485' )


           ) ).




      DATA lv_index TYPE i VALUE 0. "declarar la variable index

      SELECT FROM zcl_database_arr
      FIELDS *
      into table @data(lt_cliente).

     IF sy-subrc = 0.

      read table lt_cliente into data(ls_cliente) with key correo = 'leonardo@yahoo.es'.

     IF sy-subrc = 0.
     lv_index = sy-tabix. "sy-tabix refleja el indice (la fila donde esta el correo indicado
        else.
        lv_index = 0.           "si no existe ese correo exacto, valdra 0.

      ENDIF.
      ENDIF.

      out->write( |Ejercicio 2| ).
      out->write( |Hallar el indice del correo = leonardo@yahoo.es| ).
      out->write( lt_cliente ).
      out->write( | | ).
      out->write( | El indice en la tabla interna es: { lv_index }| ).  "{} cuidado con los espacios
      out->write( | | ).


      out->write( |Ejercicio 3 | ).
      out->write( 'Mostrar filas totales de la tabla' ).
      out->write( lines( lt_cliente ) ).


      select from zcl_database_arr
      fields *
      into table @data(lt_sustituir_letra).


    LOOP AT lt_sustituir_letra into data(ls_sustituir_letra).

     IF ls_sustituir_letra-client IS INITIAL.
    out->write( |Error en la fila { sy-tabix }: falta client | ).    "reglas de validacion
    CONTINUE.
    ENDIF.

    IF ls_sustituir_letra-nombre IS INITIAL.
    out->write( |Error en la fila { sy-tabix }: falta nombre | ).
    CONTINUE.
    ENDIF.


    if ls_sustituir_letra-edad > 24.
      data(lv_longitud) = strlen( ls_sustituir_letra-nombre ).

      if lv_longitud > 0.
         ls_sustituir_letra-nombre = substring( val = ls_sustituir_letra-nombre
                                        off = 0
                                        len = lv_longitud - 1 ) && 's'.
      ENDIF.
        MODIFY lt_sustituir_letra from ls_sustituir_letra.

  endif.
      ENDLOOP.

      modify zcl_database_arr from table @lt_sustituir_letra.

"delete lt_modificar from 2 to 4. "borra de la fila 2 hasta la 4
"delete lt_mofificar index 2.
"delete lt_modificar where nombre is INITIAL
"delete ADJACENT DUPLICATES FROM lt_mofificar COMPARING nombre.



           out->write( | | ).
           out->write( 'Ejercicio 4. Modificar la ultima letra del nombre por una S' ).
           out->write( lt_sustituir_letra ).











  ENDMETHOD.
ENDCLASS.
