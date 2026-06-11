CLASS zcl_clientes_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_clientes_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


 DELETE FROM zbd_cliente_arr.

  INSERT zbd_cliente_arr FROM TABLE @(
                         VALUE #(


  ( id = 1 nombre = 'luiss'        apellido = 'gonzalez ramirez'       direccion = 'C/mirador de la nava'  correo = 'luis@gmail.com'       telefono = '958632147' )
  ( id = 2 nombre = 'pedro'       apellido = 'ruiz rodriguez'         direccion = 'C/selva negra'         correo = 'pedro@gmail.com'      telefono = '958258974' )
  ( id = 3 nombre = 'alejandra'   apellido = 'martos diaz'            direccion = 'Callejon del angel'    correo = 'alejandra@gmail.com'  telefono = '958358987' )
  ( id = 4 nombre = 'marcos'      apellido = 'perez reverte'          direccion = 'C/flores'              correo = 'marcos@gmail.com'     telefono = '954356667' )
  ( id = 5 nombre = 'pepe'        apellido = 'garcia perez'           direccion = 'C/sierra nevada'       correo = 'pepe@gmail.com'       telefono = '955556442' )
  ( id = 6 nombre = 'lola'        apellido = 'fernandez de la piedra' direccion = 'Callejon horchuelo'    correo = 'lola@gmail.com'       telefono = '958321654' )
  ( id = 7 nombre = 'nerea'       apellido = 'matias prats'           direccion = 'C/pedregales'          correo = 'nerea@gmail.com'      telefono = '958544995' )
  )
  ).

*
*
*data ls_new_registro type zbd_cliente_arr.
*ls_new_registro = value #(  id = 11
*                            nombre = 'r'
*                           apellido = 'gonzalez ramirez'
*                           direccion = 'C/mirador de la nava'
*                           correo = 'luis@gmail.com'
*                           telefono = '958632147' ).
*
*wait up to 20 seconds.
*    MODIFY zbd_cliente_arr from @ls_new_registro.

  ENDMETHOD.
ENDCLASS.
