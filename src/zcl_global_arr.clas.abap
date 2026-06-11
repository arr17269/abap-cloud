CLASS zcl_global_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  TYPES tty_emp TYPE STANDARD TABLE OF ztab_eje_obj_arr WITH EMPTY KEY.
  " 2.3. Declaración del Constructor
    METHODS constructor
      IMPORTING
        iv_nombre          TYPE zde_nombreex_arr
        iv_apellido        TYPE zde_nombreex_arr
        iv_telefono        TYPE zde_tele_arr
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    " 2.2. Atributos privados de la clase
    DATA lt_registro     TYPE tty_emp.
    DATA ls_prueba       TYPE ztab_eje_obj_arr.
    DATA experiencia     TYPE i.
    DATA id_empleado     TYPE i.
    DATA certificaciones TYPE i.

ENDCLASS.









CLASS zcl_global_arr IMPLEMENTATION.

METHOD constructor.
    " Aquí programaremos la lógica del constructor en el siguiente paso
  ENDMETHOD.





ENDCLASS.
