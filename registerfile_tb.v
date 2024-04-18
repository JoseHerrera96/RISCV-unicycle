`include "registerfile.v"
`timescale 1us/1ns
module registerfile_tb;

    parameter CLK_PERIOD = 10; 

    reg [5:0] Read1, Read2, WriteReg;
    reg [31:0] WriteData;
    reg RegWrite, clock;
    wire [31:0] Data1, Data2;

    registerfile uut(
        .Read1(Read1),
        .Read2(Read2),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .RegWrite(RegWrite),
        .clock(clock),
        .Data1(Data1),
        .Data2(Data2)
    );

    initial begin
        $dumpfile("registerfile_tb.vcd");
        $dumpvars(0, registerfile_tb);
    end


    always #((CLK_PERIOD)/2) clock = ~clock;

     initial begin
       
        WriteReg = 3; 
        WriteData = 32'hABCDEFFF; 
        RegWrite = 1; 
        Read1 = 3; 
        Read2 = 5; 
        
        #CLK_PERIOD;
        RegWrite = 0;
        #CLK_PERIOD;
        Read1 = 7;
        Read2 = 10;
        #CLK_PERIOD;
        $finish;
    end

endmodule