# PASSWORD_FPGA

Gael Cumplido Mendoza - A01029238

Práctica: Sistema con Contraseña en FPGA DE10-Lite

📌 Descripción

Diseñar e implementar en Verilog un sistema de contraseña en la FPGA DE10-Lite utilizando Máquinas de Estados Finitos (FSM). El sistema debe:
✅ Ingresar la contraseña un switch a la vez.
✅ Evaluar una secuencia de 4 switches secuenciados.
✅ Mostrar "Done" en los displays si la secuencia es correcta.
✅ Mostrar "Error" si hay un error en cualquier punto de la secuencia.

⚙️ Requisitos

Tarjeta FPGA DE10-Lite (Intel Cyclone V)
Cable USB Blaster
Software Intel Quartus Prime Lite
Código en Verilog

📂 Estructura del Proyecto

/Password

│── Password.v # Módulo principal que implementa las funciones.

│── Password.qpf # Archivo del proyecto en Quartus

│── Password.qsf # Archivo de configuración del FPGA

│── debouncer.v # Módulo para eliminar ruido de los botones

│── oneshot.v # Módulo qu implementa un solo botonazo (si dejas presionado espues de cierto tiempo se desactivará el boton)

│── clock_divider.v # Módulo que implementa el clock dvider para ajustar el tiempo de ejecución.

│── IMAGENES #Carpeta con imagen de funcionamiento fisico

│── README.md # Este archivo
