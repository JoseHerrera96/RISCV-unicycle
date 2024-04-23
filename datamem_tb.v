`timescale 1ns / 1ps
`include "datamem.v"
module DataMemory_tb;

    // Parámetros
    parameter CLK_PERIOD = 10; // Periodo de reloj en unidades de tiempo
    
    // Señales de entrada
    reg clk;
    reg [31:0] address;
    reg [31:0] write_data;
    reg write_enable;
    reg read_enable;
    
    // Señales de salida
    wire [31:0] read_data;
    
    // Instancia del módulo DataMemory
    DataMemory data_memory (
        .clk(clk),
        .address(address),
        .write_data(write_data),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .read_data(read_data)
    );
    
    initial begin
        $dumpfile("DataMemory_tb.vcd");
        $dumpvars(0, DataMemory_tb);
    end
    // Generación de reloj
    always #((CLK_PERIOD)/2) clk = ~clk;
    
    // Testbench inicial
    initial begin
        clk = 0;
        address = 0;
        write_data = 0;
        write_enable = 0;
        read_enable = 0;
        
        // Escribir datos en la memoria
        #10 write_data = 32'hABCDEF01;
        write_enable = 1;
        address = 0;
        #10;
        
        // Leer datos de la memoria
        read_enable = 1;
        #10;
        
        // Detener simulación
        #10;
        $finish;
    end
    
    // Mostrar resultados
    always @* begin
        $display("Read Data: %h", read_data);
    end

endmodule
