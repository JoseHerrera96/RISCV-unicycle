module ALUcontrol (ALUOp, FuncCode, ALUCtl);

    input [1:0] ALUOp;
    input [5:0] FuncCode;
    output [3:0] ALUCtl;
    
     /*
        always case (FuncCode)
        32:ALUCtl<=2;
        34:ALUCtl<=6;
        36:ALUCtl<=0;
        37:ALUCtl<=1;
        default: ALUOp<=15;
        endcase

        */

    always begin @(posedge clock)
    if (ALUOp==2)
    
        if (ALUOp==0)
            ALUCtl<=2;

        else if (ALUOp==1)
            ALUCtl<=6;        
 

    end

endmodule