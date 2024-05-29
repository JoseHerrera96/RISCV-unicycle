`timescale 1ns / 1ps

module ALU_tb;

  // Inputs
  reg [31:0] operand1;
  reg [31:0] operand2;
  reg [2:0] aluOp;

  // Outputs
  wire [31:0] result;
  wire zero;

  // Instantiate the ALU module
  ALU alu (
    .operand1(operand1),
    .operand2(operand2),
    .aluOp(aluOp),
    .result(result),
    .zero(zero)
  );

  // Initialize inputs
  initial begin
    operand1 = 32'h00000001;
    operand2 = 32'h00000002;
    aluOp = 3'b000;
    #10;
    $finish;
  end

  // Display the results
  always @(result, zero)
    $display("Result: %h, Zero: %b", result, zero);

endmodule