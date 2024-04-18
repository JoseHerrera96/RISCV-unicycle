`timescale 1us/1ns
`include "RISCVALU.v"

module RISCVALU_tb;

    reg[3:0] ALUctl;
    reg[31:0] A,B;
    wire[31:0] ALUout;
    wire zero;

    RISCVALU dut(
        
        .ALUctl(ALUctl), 
        .A(A), 
        .B(B), 
        .ALUout(ALUout), 
        .zero(zero)
    );

    initial begin
        $dumpfile("RISCVALU_tb.vcd");
        $dumpvars(0, RISCVALU_tb);
    end

    initial begin
        // AND
        A = 32'h0000000F; B = 32'h0000000A; ALUctl = 4'b0000;
        #10;  // Esperar un tiempo
        $display("AND: Resultado = %h, Zero_Flag = %b", ALUout, zero);
        // OR
        A = 32'h00000000; B = 32'h0000000A; ALUctl = 4'b0001;
        #10;  // Esperar un tiempo
        $display("OR: Resultado = %h, Zero_Flag = %b", ALUout, zero);
        // Suma
        A = 32'h00000009; B = 32'h0000001; ALUctl = 4'b0010;
        #10;  // Esperar un tiempo
        $display("Suma: Resultado = %h, Zero_Flag = %b", ALUout, zero);
        // Sub
        A = 32'h0000000F; B = 32'h0000000F; ALUctl = 4'b0110;
        #10;  // Esperar un tiempo
        $display("Sub: Resultado = %h, Zero_Flag = %b", ALUout, zero);
        // if
        A = 32'h00000008; B = 32'h00000009; ALUctl = 4'b0111;
        #10;  // Esperar un tiempo
        $display("If: Resultado = %h, Zero_Flag = %b", ALUout, zero);
        // else
        A = 32'h0000000A; B = 32'h00000009; ALUctl = 4'b0111;
        #10;  // Esperar un tiempo
        $display("else: Resultado = %h, Zero_Flag = %b", ALUout, zero);
        // NOR
        A = 32'h00000000; B = 32'h0000000A; ALUctl = 4'b1100;
        #10;  // Esperar un tiempo
        $display("NOR: Resultado = %h, Zero_Flag = %b", ALUout, zero);
    end
endmodule