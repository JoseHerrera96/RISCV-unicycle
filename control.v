module control (opcode, branch, memread, MemtoReg, alu_op, memwrite, ALUsrc, regWrite, clock);
    input [6:0] opcode;
    input clock;
    output reg branch, memread, MemtoReg, memwrite, ALUsrc, regWrite;
    output reg [2:0] alu_op;

    always @(posedge clock) begin
        if (opcode == 7'b0110011) begin //opcode es de tipo R y suma
            branch = 1'b0;
            memread = 1'b0;
            MemtoReg = 1'b0;
            memwrite = 1'b0;
            ALUsrc = 1'b0;
            regWrite = 1'b1;
            alu_op = 3'b010;
        end

        if (opcode == 7'b0110011) begin //opcode es de tipo R y resta
            branch = 1'b0;
            memread = 1'b0;
            MemtoReg = 1'b0;
            memwrite = 1'b0;
            ALUsrc = 1'b0;
            regWrite = 1'b1;
            alu_op = 3'b110;
        end

        if (opcode == 7'b0110011) begin //opcode es de tipo R y AND
            branch = 1'b0;
            memread = 1'b0;
            MemtoReg = 1'b0;
            memwrite = 1'b0;
            ALUsrc = 1'b0;
            regWrite = 1'b1;
            alu_op = 3'b000;
        end

        if (opcode == 7'b0110011) begin //opcode es de tipo R y OR
            branch = 1'b0;
            memread = 1'b0;
            MemtoReg = 1'b0;
            memwrite = 1'b0;
            ALUsrc = 1'b0;
            regWrite = 1'b1;
            alu_op = 3'b001;
        end

        if (opcode == 7'b0100011) begin  //opcode es de tipo S
            branch = 1'b0;
            memread = 1'b1;
            MemtoReg = 1'b1;
            memwrite = 1'b0;
            ALUsrc = 1'b1;
            regWrite = 1'b0;
            alu_op = 3'b010;
        end
        

        if (opcode == 7'b0000011) begin //opcode es de tipo I
            branch = 1'b0;
            memread = 1'b0;
            MemtoReg = 1'b0;
            memwrite = 1'b1;
            ALUsrc = 1'b1;
            regWrite = 1'b0;
            alu_op = 3'b010;
        end
         
        if (opcode == 7'b1100011) begin //opcode es de tipo B
            branch = 1'b1;
            memread = 1'b0;
            MemtoReg = 1'b0;
            memwrite = 1'b0;
            ALUsrc = 1'b0;
            regWrite = 1'b0;
            alu_op = 3'b110;
        end 
  
          
    end
endmodule