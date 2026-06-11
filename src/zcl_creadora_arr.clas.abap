CLASS zcl_creadora_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

    " 2.1. Tipo de tabla pública para los métodos de lectura
    TYPES tty_emp TYPE STANDARD TABLE OF ztab_eje_obj_arr WITH EMPTY KEY.

    " 2.3. Declaración del Constructor
    METHODS constructor
      IMPORTING
        iv_nombre          TYPE zde_nombreex_arr
        iv_apellido        TYPE zde_nombreex_arr
        iv_telefono        TYPE zde_tele_arr
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i.

    METHODS calcular_sueldo.
    METHODS ex_id_empleado.
    METHODS alta_empleado
      RETURNING
        VALUE(rv_mensaje) TYPE string.

    METHODS modificacion
      IMPORTING
        iv_nombre          TYPE zde_nombreex_arr
        iv_apellido        TYPE zde_nombreex_arr
        iv_telefono        TYPE zde_tele_arr
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i
        iv_id_empleado     TYPE i
      RETURNING
        VALUE(rv_mensaje)  TYPE string.

   METHODS traer_lt
      IMPORTING
        iv_id_empleado   TYPE i
      RETURNING
        VALUE(rv_tabla)  TYPE tty_emp.

    METHODS traer_n_filas
      IMPORTING
        iv_n_filas       TYPE i
      RETURNING
        VALUE(rv_tabla)  TYPE tty_emp.



  PROTECTED SECTION.
  PRIVATE SECTION.

    " 2.2. Atributos privados de la clase
    DATA lt_registro     TYPE tty_emp.
    DATA ls_prueba       TYPE ztab_eje_obj_arr.
    DATA experiencia     TYPE i.
    DATA id_empleado     TYPE i.
    DATA certificaciones TYPE i.

ENDCLASS.



CLASS zcl_creadora_arr IMPLEMENTATION.


  METHOD constructor.

    " Guardamos los datos de texto en la estructura de trabajo
    me->ls_prueba-nombre        = iv_nombre.
    me->ls_prueba-apellido      = iv_apellido.
    me->ls_prueba-telefono      = iv_telefono.

    " Asignamos la moneda por defecto requerida por el enunciado
    me->ls_prueba-currency_code = 'EUR'.

    " Guardamos las variables numéricas en los atributos privados
    me->experiencia             = iv_experiencia.
    me->certificaciones         = iv_certificaciones.

  ENDMETHOD.


  METHOD calcular_sueldo.
    " Fórmula del examen: sueldo = (certificaciones * 50 + experiencia * 100) + 1000
    me->ls_prueba-sueldo = ( me->certificaciones * 50 + me->experiencia * 100 ) + 1000.
  ENDMETHOD.

  METHOD ex_id_empleado.
    " 1. Leemos el ID máximo actual usando sintaxis moderna de ABAP Cloud (@ y declaración inline)
    SELECT SINGLE MAX( id_empleado )
      FROM ztab_eje_obj_arr
      INTO @DATA(lv_max_id).



    " 2. Si se encuentra un registro con éxito, sumamos 1
    IF sy-subrc = 0 AND lv_max_id IS NOT INITIAL.
      me->ls_prueba-id_empleado = lv_max_id + 1.
    ELSE.
      " 3. Si la tabla está vacía o falla, empezamos en 0001
      me->ls_prueba-id_empleado = 1.
    ENDIF.
  ENDMETHOD.

 METHOD alta_empleado.

    " 1. Calculamos el sueldo llamando al método interno
    me->calcular_sueldo( ).

    " 2. Evaluamos el atributo privado id_empleado
    IF me->id_empleado IS NOT INITIAL.
      " Si ya viene informado (vía modificación), lo forzamos en la estructura
      me->ls_prueba-id_empleado = me->id_empleado.
    ELSEIF me->ls_prueba-id_empleado IS INITIAL.
      " Si está vacío, generamos un ID secuencial nuevo
      me->ex_id_empleado( ).
    ENDIF.

    " 3. Ejecutamos el MODIFY usando variables host con @ (Mandatorio en ABAP Cloud)
    MODIFY ztab_eje_obj_arr FROM @me->ls_prueba.

    " 4 y 5. Si la base de datos responde OK, guardamos cambios permanentemente
    IF sy-subrc = 0.
      COMMIT WORK.
      rv_mensaje = 'Subida correcta.'.
    ELSE.
      rv_mensaje = 'Error en la Subida.'.
    ENDIF.

  ENDMETHOD.

 METHOD modificacion.
    " 1. Sobrescribimos atributos y estructura con los datos de entrada
    me->id_empleado             = iv_id_empleado.
    me->experiencia             = iv_experiencia.
    me->certificaciones         = iv_certificaciones.

    me->ls_prueba-nombre        = iv_nombre.
    me->ls_prueba-apellido      = iv_apellido.
    me->ls_prueba-telefono      = iv_telefono.
    me->ls_prueba-currency_code = 'EUR'.
    me->ls_prueba-id_empleado   = iv_id_empleado.

    " 2. Comprobamos si el ID existe en la base de datos
    SELECT SINGLE @abap_true
      FROM ztab_eje_obj_arr
      WHERE id_empleado = @me->id_empleado
      INTO @DATA(lv_existe).

    " 3 y 4. Si existe, reutilizamos el método alta_empleado; si no, disparamos error
    IF sy-subrc = 0 AND lv_existe = abap_true.
      rv_mensaje = me->alta_empleado( ).
    ELSE.
      rv_mensaje = 'El ID no existe en la base de datos, no se ha podido hacer la modificación.'.
    ENDIF.

  ENDMETHOD.




 METHOD traer_lt.
    IF iv_id_empleado = 0.
      " Si el ID es 0, extraemos todos los registros ordenados por id_empleado
      SELECT *
        FROM ztab_eje_obj_arr
        ORDER BY id_empleado ASCENDING
        INTO TABLE @me->lt_registro.
    ELSE.
      " Si es un ID concreto, filtramos por la condición WHERE
      SELECT *
        FROM ztab_eje_obj_arr
        WHERE id_empleado = @iv_id_empleado
        INTO TABLE @me->lt_registro.
    ENDIF.

    " Asignamos el atributo privado al parámetro de retorno
    rv_tabla = me->lt_registro.


  ENDMETHOD.

 METHOD traer_n_filas.
    " Extraemos las primeras N filas usando la variable del parámetro escapada con @
    SELECT *
      FROM ztab_eje_obj_arr
      ORDER BY id_empleado ASCENDING
      INTO TABLE @me->lt_registro
      UP TO @iv_n_filas ROWS.

    " Devolvemos la tabla resultante
    rv_tabla = me->lt_registro.


  ENDMETHOD.

ENDCLASS.
