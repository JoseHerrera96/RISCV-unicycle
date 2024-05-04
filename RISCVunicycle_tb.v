`timescale 1us/1ns
`include "RISCVunicycle.v"

module RISCVALU_tb;

    parameter CLK_PERIOD = 10000; 

    reg[3:0] ALUctl;
    reg[31:0] A,B;
    wire[31:0] ALUout;
    wire zero;

    RISCVunicycle dut(
        
        
    );

    initial begin
        $dumpfile("RISCVALU_tb.vcd");
        $dumpvars(0, RISCVALU_tb);
    end