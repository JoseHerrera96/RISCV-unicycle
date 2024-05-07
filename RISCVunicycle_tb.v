`timescale 1us/1ns
`include "RISCVunicycle.v"

module RISCVunicycle_tb;

    parameter CLK_PERIOD = 10000; 

      reg clock, rst;

    RISCVunicycle dut(
        .clk(clock),
        .reset(rst)
        
    );

    initial begin
        $dumpfile("RISCVunicycle_tb.vcd");
        $dumpvars(0, RISCVunicycle_tb);
    end

    always #((CLK_PERIOD)/2) clock = ~clock;

    initial begin
        rst=0;
        #10;
        rst=1;
        rst=0;
        #10;
    end

endmodule
