CLASS zcl_main_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_main_arr IMPLEMENTATION.




  METHOD if_oo_adt_classrun~main.
    " 1. Variable de control que sirve de menú para las pruebas (Cámbiala para testear)
    DATA lv_accion TYPE i VALUE 3.

    " 2. Instanciamos la clase de negocio con los datos de ejemplo del constructor
    DATA(lo_creadora) = NEW zcl_creadora_arr(
      iv_nombre          = 'Natalia'
      iv_apellido        = 'Ruiz'
      iv_telefono        = '666555777'
      iv_experiencia     = 4
      iv_certificaciones = 2
    ).

    " Variables auxiliares para recoger las respuestas de los métodos
    DATA lv_mensaje TYPE string.
    DATA lt_resultado TYPE zcl_creadora_arr=>tty_emp.

    " 3. Implementación del menú CASE según el requerimiento del examen
    CASE lv_accion.

      WHEN 1.
        " Acción 1: Alta del empleado configurado en el constructor
        lv_mensaje = lo_creadora->alta_empleado( ).
        out->write( lv_mensaje ).

      WHEN 2.
        " Acción 2: Modificación con datos nuevos y un ID concreto (p. ej. 10)
        lv_mensaje = lo_creadora->modificacion(
          iv_id_empleado     = 10
          iv_nombre          = 'Natalia Modificada'
          iv_apellido        = 'Ruiz'
          iv_telefono        = '999888777'
          iv_experiencia     = 5
          iv_certificaciones = 3
        ).
        out->write( lv_mensaje ).

      WHEN 3.
        " Acción 3: Traer toda la tabla (pasando 0)
        lt_resultado = lo_creadora->traer_lt( iv_id_empleado = 0 ).
        out->write( lt_resultado ).

      WHEN 4.
        " Acción 4: Traer solo las 2 primeras filas
        lt_resultado = lo_creadora->traer_n_filas( iv_n_filas = 2 ).
        out->write( lt_resultado ).

      WHEN OTHERS.
        out->write( 'Acción no válida en el menú.' ).

    ENDCASE.
  ENDMETHOD.







ENDCLASS.
