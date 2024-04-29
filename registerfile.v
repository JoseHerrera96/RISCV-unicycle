module registerfile(Read1,Read2,RD,WriteData,RegWrite,Data1,Data2,clock);

    input[5:0] Read1,Read2,RD;
    input[31:0] WriteData;
    input RegWrite, clock;
    output [31:0] Data1, Data2;
    reg [31:0] RF [31:0];

    assign Data1=RF[Read1];
    assign Data2=RF[Read2];


    always begin @(posedge clock) 
        if (RegWrite==1) 
            RF[RD]<=WriteData;
    end
endmodule
