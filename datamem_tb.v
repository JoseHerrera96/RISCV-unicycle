`timescale 1us/1ns
`include "datamem.v"
module DataMemory_tb;

    parameter CLK_PERIOD = 10; 

    reg clk;
    reg [31:0] address, write_data;
    reg write_enable, read_enable;
    wire [31:0] read_data;

    DataMemory uut(
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
    always #((CLK_PERIOD)/2) clk = ~clk;

    initial begin
        write_enable = 1;
        read_enable = 0;
        address = 10;
        write_data = 32'hABCDEFFF;
        #CLK_PERIOD;
        write_enable = 0;
        read_enable = 1;
        address = 10;
        #CLK_PERIOD;
        address = 20;
        #CLK_PERIOD;
        $finish;
    end

endmodule
