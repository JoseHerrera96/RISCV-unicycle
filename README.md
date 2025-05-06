Este repositorio contiene la implementación de un procesador uniciclo basado en la arquitectura RISC-V (rv32i) para el curso EL3310 - Diseño de Sistemas Digitales, TEC. El proyecto está organizado en dos carpetas principales:

- **src/**: Contiene todos los archivos fuente SystemVerilog de los módulos principales (ALU, memoria, registros, etc.).
- **tb/**: Incluye los testbenches y archivos de simulación para validar cada módulo y la integración del procesador.

También se incluyen archivos de programas de prueba en ensamblador y archivos .hex para la validación funcional.

Para comenzar:
1. Revise los módulos en `src/` y los testbenches en `tb/`.
2. Compile y simule usando su herramienta preferida (por ejemplo, Icarus Verilog).
3. Utilice los archivos `.hex` para cargar instrucciones y datos en memoria durante la simulación.

---



