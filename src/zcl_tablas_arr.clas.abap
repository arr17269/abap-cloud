CLASS zcl_tablas_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tablas_arr IMPLEMENTATION.
 METHOD if_oo_adt_classrun~main.


  types: BEGIN OF ty_persona,
       nombre   TYPE string,
       edad     TYPE i,
       telefono TYPE  string, "el telefono es string
       email type string,
   END OF TY_persona.



  DATA lt_cliente type table of ty_persona.
  data lt_empleado type TABLE of ty_persona.
  data ls_cliente type ty_persona.

* ls_cliente-nombre = 'Toñi'.
* ls_cliente-edad = 33.
* ls_cliente-telefono = '+34958265471'.
* ls_cliente-email = 'toniar1969@gmail.com'.
*
* insert ls_cliente into table lt_empleado.

 ls_cliente-nombre = 'dani'.
 ls_cliente-edad = 33.
 ls_cliente-telefono = '+34958265471'.
 ls_cliente-email = 'toniar1969@gmail.com'.

 insert ls_cliente into table lt_cliente.

 ls_cliente-nombre = 'Paco'.
 ls_cliente-edad = 43.
 ls_cliente-telefono = '+34958265471'.
 ls_cliente-email = 'toniar1969@gmail.com'.

 insert ls_cliente into table lt_cliente.


 ls_cliente-nombre = 'Laura'.
 ls_cliente-edad = 33.
 ls_cliente-telefono = '+34958265471'.
 ls_cliente-email = 'toniar1969@gmail.com'.

 insert ls_cliente into lt_cliente index 2. " el index fuerza una posicion contreta en el regustro de una tabla

 ls_cliente-nombre = 'Raul'.
 ls_cliente-edad = 23.
 ls_cliente-telefono = '+34958265471'.
 ls_cliente-email = 'toniar1969@gmail.com'.

 insert ls_cliente into lt_cliente index 3.
"out->write( lt_cliente ) .


    loop at lt_cliente into ls_cliente.
            out->write( ls_cliente ).
        if ls_cliente-edad = 33.
            out->write( 'ahora estoy dentro del if' ).
            out->write( ls_cliente ).
        endif.
    endloop.



"""""""""""""""""""""""""""""""""

   types: BEGIN OF ty_persona2,
       animal   TYPE string,
       edad     TYPE i,
       telefono TYPE  string, "el telefono es string
       email type string,
   END OF TY_persona2.

  data lt_animal type table of ty_persona2.
  data ls_animal type ty_persona2.


" con esta forma no necesitamos de una estructura para introducir datos en una tabla
 insert value #( animal = 'perro' edad = 12 telefono = '3333' email = 'alsdfjas' ) into table lt_animal.
 insert value #( animal = 'gato' edad = 12 telefono = '3333' email = 'alsdfjas' ) into table lt_animal.
 insert value #( animal = 'loro' edad = 12 telefono = '3333' email = 'alsdfjas' ) into  lt_animal index 2.



    loop at lt_animal into ls_animal.

        if ls_animal-animal = 'perro'.
       " out->write( | nombre del animal: {  ls_animal-animal }  edad {  ls_animal-edad }| ).
        endif.
    endloop.


  ENDMETHOD.
ENDCLASS.
