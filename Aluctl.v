module ALUcontrol (ALUOp, FuncCode, ALUCtl);

    input [1:0] ALUOp;
    input [5:0] FuncCode;
    output [3:0] ALUCtl;
    
    
    if (ALUOp==2)begin
        always case (FuncCode)  
        32:ALUCtl<=2;
        34:ALUCtl<=6;
        36:ALUCtl<=0;
        37:ALUCtl<=1;
        default: ALUOp<=15;
        endcase
    end

    if (ALUOp==0)begin  
        aALUCtl=2;
    end

    if (ALUOp==1)begin
        ALUCtl=6;        
    end

endmodule