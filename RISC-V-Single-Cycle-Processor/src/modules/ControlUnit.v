module ControlUnit (
  input wire [5:0] opcode,
  output wire RegWrite,
  output wire MemRead,
  output wire MemWrite,
  output wire [1:0] ALUOp,
  output wire [2:0] ALUSrc,
  output wire Branch,
  output wire Jump,
  output wire [1:0] PCSource,
  output wire [1:0] RegDst
);
  // Control signals
  assign RegWrite = (opcode == 6'b000000 || opcode == 6'b000001 || opcode == 6'b000010);
  assign MemRead = (opcode == 6'b000011);
  assign MemWrite = (opcode == 6'b000100);
  assign ALUOp = (opcode == 6'b000000 || opcode == 6'b000001 || opcode == 6'b000010) ? 2'b00 :
                (opcode == 6'b000011) ? 2'b01 :
                (opcode == 6'b000100) ? 2'b10 : 2'b11;
  assign ALUSrc = (opcode == 6'b000000 || opcode == 6'b000001 || opcode == 6'b000010) ? 3'b000 :
                 (opcode == 6'b000011) ? 3'b001 :
                 (opcode == 6'b000100) ? 3'b010 :
                 (opcode == 6'b000101) ? 3'b011 :
                 (opcode == 6'b000110) ? 3'b100 :
                 (opcode == 6'b000111) ? 3'b101 :
                 (opcode == 6'b001000) ? 3'b110 :
                 (opcode == 6'b001001) ? 3'b111 : 3'b000;
  assign Branch = (opcode == 6'b000101);
  assign Jump = (opcode == 6'b000110);
  assign PCSource = (opcode == 6'b000101) ? 2'b01 :
                   (opcode == 6'b000110) ? 2'b10 : 2'b00;
  assign RegDst = (opcode == 6'b000000) ? 2'b00 :
                 (opcode == 6'b000001) ? 2'b01 :
                 (opcode == 6'b000010) ? 2'b10 : 2'b11;
endmodule