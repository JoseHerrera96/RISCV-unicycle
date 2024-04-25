module ALUcontrol (ALUOp, FuncCode, ALUCtl);

    input [1:0] ALUOp;
    input [5:0] FuncCode;
    output reg [3:0] ALUCtl;
    
     
        always @*
        if (ALUOp==2) begin
            case (FuncCode)
            32:ALUCtl<=2;
            34:ALUCtl<=6;
            36:ALUCtl<=0;
            37:ALUCtl<=1;
            
            default: ALUCtl<=15;
        endcase
        end

        else if (ALUOp==1)begin
            ALUCtl=3;
        end
        else if (ALUOp==0)begin
            ALUCtl=2;
        end

endmodule