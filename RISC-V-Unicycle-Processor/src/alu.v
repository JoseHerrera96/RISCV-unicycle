module alu (
  input [31:0] operand1,
  input [31:0] operand2,
  input [2:0] aluOp,
  output reg [31:0] result,
  output reg zero
);

  always @(*) begin
    case (aluOp)
      3'b000: result = operand1 + operand2; // add
      3'b001: result = operand1 - operand2; // sub
      3'b010: result = operand1 & operand2; // and
      3'b011: result = operand1 | operand2; // or
      default: result = 32'b0;
    endcase

    zero = (result == 0);
  end

endmodule