`timescale 1ns/1ps
`include "signext.v"

module signext_tb;

    reg [31:0] instruct;
    reg [6:0] typ;
    reg [11:0] inm;
    wire [31:0] out;

    // Instancia del módulo signext
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
        $display(" ");
        $display("Inicializando testbench de signext...");
        $display(" ");

        // Prueba de Tipo I
        typ = 7'b0010011; // Tipo I
        instruct = 32'h00000FFF; // Inmediato positivo
        inm = instruct[31:20];
        #10;
        $display("Tipo I (Positivo): Instruccion = %h, Inm: %d, Extendido = %h", instruct, inm, out);

        instruct = 32'hFFFFF800; // Inmediato negativo
        inm = instruct[31:20];
        #10;
        $display("Tipo I (Negativo): Instruccion = %h, Inm: %d, Extendido = %h", instruct, inm, out);

        $display(" ");

        // Prueba de Tipo L
        typ = 7'b0000011; // Tipo L
        instruct = 32'h00000FFF; // Dirección de memoria positiva
        inm = {instruct[31:25], instruct[11:7]}; 
        #10;
        $display("Tipo L (Positivo): Instruccion = %h, Inm: %d, Extendido = %h", instruct, inm, out);

        instruct = 32'hFFFFF800; // Dirección de memoria negativa
        inm = {instruct[31:25], instruct[11:7]};
        #10;
        $display("Tipo L (Negativo): Instruccion = %h, Inm: %d, Extendido = %h", instruct, inm, out);

        $display(" ");

        // Prueba de Tipo S
        typ = 7'b0100011; // Tipo S
        instruct = 32'h00000FFF; // Dirección de memoria positiva
        inm = {instruct[31], instruct[7], instruct[30:25], instruct[11:8]};
        #10;
        $display("Tipo S (Positivo): Instruccion = %h, Inm: %d, Extendido = %h", instruct, inm, out);

        instruct = 32'hFFFFF800; // Dirección de memoria negativa
        inm = {instruct[31], instruct[7], instruct[30:25], instruct[11:8]};
        #10;
        $display("Tipo S (Negativo): Instruccion = %h, Inm: %d, Extendido = %h", instruct, inm, out);

        $display(" ");
        $display("Testbench finalizado.");
        $display(" ");
        $finish;
    end

endmodule