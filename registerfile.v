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
    RF[5'd0] = 32'd0;   // x0: 
    RF[5'd1] = 32'd0;   // x1
    RF[5'd2] = 32'd4;   // x2
    RF[5'd3] = 32'd2;   // x3
    RF[5'd4] = 32'd2;   // x4
    RF[5'd5] = 32'd2;   // x5
    RF[5'd6] = 32'd5;   // x6
    RF[5'd7] = 32'd0;   // x7
    RF[5'd8] = 32'd0;   // x8
    RF[5'd9] = 32'd0;   // x9
    RF[5'd10] = 32'd1;  // x10
    RF[5'd11] = 32'd0;  // x11
    RF[5'd12] = 32'd0;  // x12
    RF[5'd13] = 32'd0;  // x13
    RF[5'd14] = 32'd0;  // x14
    RF[5'd15] = 32'd0;  // x15
    RF[5'd16] = 32'd0;  // x16
    RF[5'd17] = 32'd0;  // x17
    RF[5'd18] = 32'd0;  // x18
    RF[5'd19] = 32'd0;  // x19
    RF[5'd20] = 32'd0;  // x20
    RF[5'd21] = 32'd0;  // x21
    RF[5'd22] = 32'd0;  // x22
    RF[5'd23] = 32'd0;  // x23
    RF[5'd24] = 32'd0;  // x24
    RF[5'd25] = 32'd0;  // x25
    RF[5'd26] = 32'd0;  // x26
    RF[5'd27] = 32'd0;  // x27
    RF[5'd28] = 32'd0;  // x28
    RF[5'd29] = 32'd0;  // x29
    RF[5'd30] = 32'd0;  // x30
    RF[5'd31] = 32'd0;  // x31
end

    always @(posedge clock) begin
        if (RegWrite==1) 
            RF[RD]<=WriteData;
    end
endmodule
