//`timescale 1us/1ns
`include "Instmemory.v"
module instmemory_tb;

    // Parámetros
    parameter CLK_PERIOD = 2; // Periodo del reloj en unidades de tiempo

    // Definición de señales
    reg [31:0] Read1, WriteReg, WriteData;
    reg RegWrite, clock;
    wire [31:0] instruct;

    // Instancia del módulo a probar
    instmemory uut(
        .addr(Read1),
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
        // Leer la instrucción de la memoria de instrucciones
        Read1 = 0; // Leer de la dirección 0
        // Simular un ciclo de reloj para leer los datos
        #CLK_PERIOD;
        // Cambiar la dirección de lectura
        Read1 = 1; // Leer de la dirección 1
        // Simular un ciclo de reloj para leer los datos
        #CLK_PERIOD;
        $display("instruccion= %h", instruct);
    
        // Finalizar la simulación
        $finish;
    end

endmodule

