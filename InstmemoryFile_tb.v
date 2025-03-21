`include "Instmemory.v"
`timescale 1ns / 1ps

module instmemory_tb;

    // Señales de prueba
    reg [31:0] addr;
    wire [31:0] instruct;
    reg clock;

    // Instancia del módulo instmemory
    instmemory uut (
        .addr(addr),
        .instruct(instruct),
        .clock(clock)
    );

    // Generador de reloj
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // Reloj con periodo de 10 unidades de tiempo
    end

    initial begin
        // Inicialización de señales
        addr = 0;

        // Esperar a que se carguen las instrucciones
        #10;

        // Leer las instrucciones en diferentes direcciones
        addr = 0;
        #10;
        $display("Address: %d, Instruction: %h", addr, instruct);

        addr = 1;
        #10;
        $display("Address: %d, Instruction: %h", addr, instruct);

        addr = 2;
        #10;
        $display("Address: %d, Instruction: %h", addr, instruct);

        addr = 3;
        #10;
        $display("Address: %d, Instruction: %h", addr, instruct);

        // Finalizar la simulación
        #10;
        $finish;
    end

endmodule