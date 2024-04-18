`timescale 1ps/1ps
`include "control.v"

module control_tb;

    reg [6:0] opcode;
    reg clock;
    wire branch;
    wire memread;
    wire MemtoReg;
    wire memwrite;
    wire ALUsrc;
    wire regWrite;
    wire [2:0] alu_op;

    control dut (
        .opcode(opcode),
        .clock(clock), 
        .branch(branch), 
        .memread(memread),
        .MemtoReg(MemtoReg),
        .memwrite(memwrite),
        .ALUsrc(ALUsrc),
        .regWrite(regWrite),
        .alu_op(alu_op)

    );

    initial begin
        
        $dumpfile ("Control_tb.vcd");
        $dumpvars (0,control_tb);

        clock = 1'b0;
        #5;
        
        opcode = 7'b0110011;
        clock = 1'b1;
        #5;

        clock = 1'b0;
        #5;

        opcode = 7'b0100011;
        clock = 1'b1;
        #5;

        clock = 1'b0;
        #5;

        opcode = 7'b0000011;
        clock = 1'b1;
        #5;

        clock = 1'b0;
        #5;

        opcode = 7'b1100011;
        clock = 1'b1;
        #10;
    end
endmodule