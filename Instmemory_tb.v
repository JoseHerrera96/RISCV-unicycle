`timescale 1us/1ns
`include "Instmemory.v"
module instmemory_tb;

    // Parámetros
    parameter CLK_PERIOD = 1; // Periodo del reloj en unidades de tiempo

    // Definición de señales
    reg [31:0] Read1, WriteReg, WriteData;
    reg RegWrite, clock;
    wire [31:0] instruct;

    // Instancia del módulo a probar
    instmemory uut(
        .addr(Read1),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .RegWrite(RegWrite),
        .instruct(instruct),
        .clock(clock)
    );

    initial begin
        $dumpfile("instmemory_tb.vcd");
        $dumpvars(0, instmemory_tb);
    end

    // Generación de clock
    always #((CLK_PERIOD)/2) clock = ~clock;

    // Inicialización de señales
    initial begin
        // Escribir datos en la memoria de instrucciones
        WriteReg = 0; // Escribir en la dirección 0
        RegWrite = 32'd1; // Habilitar la escritura
        WriteData = 32'h00A200B3; // Datos de instrucción a escribir
        // Simular un ciclo de reloj para escribir los datos
        #CLK_PERIOD;
        // Desactivar la escritura
        RegWrite = 0;
        // Leer la instrucción de la memoria de instrucciones
        Read1 = 0; // Leer de la dirección 0
        // Simular un ciclo de reloj para leer los datos
        #CLK_PERIOD;
        // Cambiar la dirección de lectura
        Read1 = 1; // Leer de la dirección 1
        // Simular un ciclo de reloj para leer los datos
        #CLK_PERIOD;
        // Finalizar la simulación
        $finish;
    end

endmodule

