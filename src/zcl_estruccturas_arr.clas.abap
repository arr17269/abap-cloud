CLASS zcl_estruccturas_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ESTRUCCTURAS_ARR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* data: lv_sofa type string,
*       lv_mesa type string,
*       lv_cama type string,
*       lv_lampara TYPE string.  "acaba con punto.
*
* types:BEGIN OF ty_mobiliario,"hay que crear nuestros tipos para que la estructura sepa el tipo que queremos insertar en los campos.
*        sofa type string,
*        mesa type string,
*        cama type string,
*        lampara type string, "acaba con coma.
*
*        End of ty_mobiliario.
*
*  data: ls_mobiliario TYPE ty_mobiliario.
*
*
*    ls_mobiliario-sofa = 'sofa amarillo 2 plazas'.
*    ls_mobiliario-mesa = 'mesa redonda'.
*    ls_mobiliario-cama = 'cama 70 cm'.
*    ls_mobiliario-lampara = 'con 4 luces'.
*
*        out->write( ls_mobiliario ).

DATA:BEGIN OF ls_empleado,
     nombre type string VALUE 'laura',
     id TYPE i,
     email TYPE /dmo/email_address value 'toniarr1969@yalosabes',

End of ls_empleado.
    data: BEGIN OF ls_empleado_info,

          begin of info,
          id TYPE i VALUE 01,
          nombre type string VALUE 'toñi',
          END OF INFO,

          BEGIN OF direccion,
          ciudad type string VALUE 'Madrid',
          calle type string VALUE 'norfeo',
          pais type string value 'España',
          END OF direccion,


          BEGIN OF posicion,
          departamento type string VALUE 'it',
          sueldo type p decimals 2 value '2000.55',
          END OF POSICION,

          end of LS_EMPLEADO_INFO.
          out->write( ls_empleado_info ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""
types: begin of ty_persona,
       nombre TYPE ZDE_NOMBRE_DER,
       edad type ZDE_EDAD_ARR,
       correo type ZDE_CORREO_ARR,
       telefono type string, "declarar los tipos
END of TY_persona.


data ls_persona type ty_persona."así se declara una estructura con 'ls_

ls_persona-nombre = 'Carlos'. "introducir datos de forma antigua.

*data(lv_var) = 'y'. "se declara el tipo directamente con los parentesis.
*data(lv_var1) = 2. "ya sabe que es tipo i

ls_persona = value #( nombre = 'lalal' "la almohadilla significa que el tipo ha sido declarado previamente.
                        edad = 14
                        telefono = '142588' ). "declaraciones en línea. Forma de agregar datos de forma moderna.

                        out->write( ls_persona ).


data(ls_persona2) = value ty_persona(               "declarar una estructura sin declarar tipo previamente.
                          nombre = 'lalaa'
                          edad = 14
                          telefono = '1254' ).

data(lv_persona) = ls_persona2-nombre.
out->write( lv_persona ).








  ENDMETHOD.
ENDCLASS.
