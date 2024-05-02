//`timescale 1ns/1ps
`include "signext.v"
module signext_tb;

    //parameter CLK_PERIOD = 10; // Periodo de reloj en unidades de tiempo

    reg [31:0] instruct;
    reg [6:0] typ;
    wire [31:0] out;
    
    signext dut(
        .instruct(instruct),
        .out(out),
        .typ(typ)
    );
    initial begin
        $dumpfile("signext_tb.vcd");
        $dumpvars(0, signext_tb);
    end
    
    initial begin
        // Establecer valores iniciales
        instruct = 32'h00000000;
        typ = 7'b0000000;
        
        // Establecer diferentes tipos de instrucciones para probar la extensión de signo
        // Tipo I
        typ = 7'b0010011;
        instruct = 32'h0000FFFF; // Ejemplo de inmediato positivo
        #10;
        $display("Inmeadiato con signo extendido: %b,", out);
        instruct = 32'hFFFF0000; // Ejemplo de inmediato negativo
        #10;
        $display("Inmeadiato con signo extendido: %b,", out);
        
        // Tipo L
        typ = 7'b0000011;
        instruct = 32'h0000FFFF; // Ejemplo de dirección de memoria positiva
        #10;
        $display("Inmeadiato con signo extendido: %b,", out);
        instruct = 32'hFFFF0000; // Ejemplo de dirección de memoria negativa
        #10;
        $display("Inmeadiato con signo extendido: %b,", out);
        
        // Tipo S
        typ = 7'b0100011;
        instruct = 32'h0000FFFF; // Ejemplo de dirección de memoria positiva
        #10;
        $display("Inmeadiato con signo extendido: %b,", out);
        instruct = 32'hFFFF0000; // Ejemplo de dirección de memoria negativa
        #10;
        $display("Inmeadiato con signo extendido: %b,", out);
        
        // Detener simulación
        #10;
        $finish;
    end

endmodule
