module ALU (
  input [31:0] operand1,
  input [31:0] operand2,
  input [2:0] aluOp,
  output reg [31:0] result,
  output reg zero
);

  always @(*) begin
    case (aluOp)
      3'b000: result = operand1 + operand2; // ADD
      3'b001: result = operand1 - operand2; // SUB
      3'b010: result = operand1 & operand2; // AND
      3'b011: result = operand1 | operand2; // OR
      3'b100: result = operand1 ^ operand2; // XOR
      3'b101: result = operand1 << operand2; // SLL
      3'b110: result = operand1 >> operand2; // SRL
      3'b111: result = operand1 >>> operand2; // SRA
      default: result = 32'b0;
    endcase

    zero = (result == 32'b0);
  end

endmodule