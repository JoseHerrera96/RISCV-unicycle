module registerfile(Read1,Read2,RD,WriteData,RegWrite,Data1,Data2,clock);

    input[4:0] Read1,Read2,RD;
    input[31:0] WriteData;
    input RegWrite, clock;
    output wire [31:0] Data1, Data2;
    reg [31:0] RF [31:0];

    assign Data1=RF[Read1];
    assign Data2=RF[Read2];
    always @* begin
        $display("Data1: %d", Data1);
        $display("Data2: %d", Data2);
    end
    always @* begin
        $display("WriteData: %d", WriteData);
    end
    
    initial begin
        RF[5'd4]= 32'd2;
        RF[5'd10]= 34'd1;
        RF[5'd2]= 32'd4;
        RF[5'd3]= 32'd2;
        RF[5'd5]= 32'd2;
        RF[5'd6]= 32'd5;
    end

    always @(posedge clock) begin
        if (RegWrite==1) 
            RF[RD]<=WriteData;
    end
endmodule
