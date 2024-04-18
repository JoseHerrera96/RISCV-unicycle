# Proyecto corto: Implementación de un procesador básico uniciclo basado en `rv32i`
### EL3310 - Diseño de Sistemas Digitales
### Escuela de Ingeniería Electrónica
### Tecnológico de Costa Rica

<br/><br/>

## Preámbulo

Para el desarrollo de este proyecto corto, usted deberá guiarse por la documentación que se encuentra en el capítulo 2 del libro *Computer Organization and Design: The Hardware Software Interface, RISC-V edition*.


## Procesador uniciclo basado en `rv32i`

De acuerdo con lo visto en clase, usted desarrollará un procesador uniciclo como el que muestra en la siguiente figura.

![Diagrama de bloques para el procesador uniciclo](https://github.com/TEC-EL3310/proyecto1/blob/main/figs/uniclycle.png?raw=true "Diagrama de bloques de un procesador uniciclo basado en `rv32i`")


Para este proyecto, usted implementará los siguientes bloques funcionales:
- ALU
- Archivo de registros
- Memoria de instrucciones
- Memoria de datos
- Generador de inmediatos
- Unidad de control
- ALU control

además de los sumadores y multiplexores necesarios para completar su implementación. Asegúrese de desarrollar un *testbench* para cada uno de los anteriores bloques, de manera que tenga certeza de su funcionalidad antes de integrarlos para construir su procesador.

Las instrucciones que su implementación deberá soportar son, al menos,
```asm
add
sub
and
or
lw
sw
beq
```

## Programas de prueba
Deberá escribir al menos 2 programas, en lenguaje ensamblador, que le permitan estresar su diseño y asegurarse de que funciona apropiadamente para el soporte de las instrucciones esperadas. Dichos programas deben tener algún sentido algorítmico y no ser simplemente una serie de instrucciones que no ejecutan algo con sentido.


## Evaluación
Este proyecto corto se evaluará con la siguiente rúbrica. Se entregará con anterioridad a la revisión el archivo `.hex` para el rubro "Validación funcional del procesador con programa proveído".


| Rubro | % | C | EP | D | NP |
|-------|---|---|----|---|----|
|Desarrollo de bloques individuales| 20 |   |    |   |    |
|Validación funcional de bloques individuales mediante testbenches |20|   |    |   |    |
|Programas de prueba desarollados |10|   |    |   |    |
|Integración del procesador |10|   |    |   |    |
|Validación funcional del procesador con programas de desarrollados  |10|   |    |   |    |
|Validación funcional del procesador con programa proveído  |20|   |    |   |    |
|Uso de repositorio |10|   |    |   |    |

C: Completo,
EP: En progreso ($\times 0,8$),
D: Deficiente ($\times 0,5$),
NP: No presenta ($\times 0$)

La revisión de este proyecto corto se realizará durante la clase del viernes 5 de abril de 2024. PAra el rubro de "Uso de repositorio" se que existan contribuciones de todos los miembros del equipo. El último _commit_ debe registrarte antes de las 17:00 del viernes 5 de abril de 2024.

