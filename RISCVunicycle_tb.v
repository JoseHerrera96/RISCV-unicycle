//`timescale 1us/1ns
`include "RISCVunicycle.v"

module RISCVunicycle_tb;

    parameter CLK_PERIOD = 2; 

    reg clock, rst;

    RISCVunicycle dut(
        .clk(clock),
        .reset(rst)
        
    );
    initial begin
        $dumpfile("RISCVunicycle_tb.vcd");
        $dumpvars(0, RISCVunicycle_tb);
    end

   //always begin
        //#5 clock = ~clock;
    //end

    initial begin
        clock=0;
        rst=1;
        #100;
        clock=1;
        rst=0;
        #100;
        clock=0;
        #100;
        clock=1;
        #100;
        clock=0;
        #100;
        $finish;
    end

endmodule
