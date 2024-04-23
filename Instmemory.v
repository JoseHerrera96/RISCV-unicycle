module instmemory(addr,WriteReg,WriteData,RegWrite,instruct,clock);
    input [31:0] addr,WriteReg;
    input [31:0] WriteData;
    input RegWrite, clock;
    output wire [31:0] instruct;
    reg [31:0] RF [31:0];

    initial begin
        
        RF[0]= 32'h00A200B3;
        RF[1]= 32'h40120133;
    end
    always @(posedge clock) begin 
        if (RegWrite==1) 
            RF[WriteReg]<=WriteData;
    end
    assign instruct=RF[addr];
endmodule