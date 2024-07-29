`timescale 1ms/1us
`include "RISCVunicycle.v"

module RISCVunicycle_tb;

    parameter CLK_PERIOD = 2; 

    reg clock, rst;

    RISCVunicycle dut(
        .clock(clock),
        .rst(rst)
        
    );
    initial begin
        $dumpfile("RISCVunicycle_tb.vcd");
        $dumpvars(0, RISCVunicycle_tb);
    end

   //always begin
        //#5 clock = ~clock;
    //end
    initial begin
        rst=0;
        clock=0;
    end

    initial begin
        clock=0;
        rst=1;
        rst=0;
        #1000;
        clock=1;
        #1000;
        /*
        clock=0;
        #1000;
        clock=1;
        #1000;
        clock=0;
        #1000;
        clock=1;
        #1000;
        $finish;
        */
    end

endmodule
