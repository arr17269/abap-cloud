CLASS zcl_estr_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_estr_arr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

DATA lv_var type i value 5.
types: BEGIN OF ty_persona,
       nombre   TYPE string,
       edad     TYPE i,
       telefono TYPE  string, "el telefono es string
        email type string,
        END OF TY_persona.
 "hemos declarado un tipo de estructura.
 DATA ls_persona type ty_persona.
 "la estructura se declara con ls
 data ls_cliente TYPE ty_persona.
 data ls_empleado TYPE ty_persona.
 "podemos utilizar el mismo tipo en las 3 estructuras (persona, cliente , empleado)

 out->write( ls_empleado ).

 ls_cliente-nombre = 'Toñi'.
 ls_cliente-edad = 33.
 ls_cliente-telefono = '+34958265471'.
 ls_cliente-email = 'toniar1969@gmail.com'.

 ls_empleado-nombre = 'Paco'.
 ls_empleado-edad = 50.

out->write( ls_empleado ).
out->write( ls_cliente ).
out->write( ls_persona ).

"otra forma de rellenar la estructura, ponemos el data porque es una estructura no declarada anteriormente, se la pone el tipo (ty_persona) y se le asignan valores.
DATa(ls_persona2) = value ty_persona( nombre = 'Toñi' edad = 32 email = 'toniarr1969@gmail.com' ).


"esta estructura se ha declarado en la linea 26, por eso, no ponemos el data y sí ponemos el #.
ls_persona = value #(
            nombre = 'Fernando'
            edad = 32
            email = 'Daniel'
            telefono = '6000000' ).







  ENDMETHOD.

ENDCLASS.
