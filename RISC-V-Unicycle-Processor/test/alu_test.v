module alu_test;
  // Testbench code for the ALU module

  // Include the ALU module
  `include "../src/alu.v"

  // Define the testbench inputs and outputs
  reg [31:0] a, b;
  reg [2:0] alu_op;
  wire [31:0] result;

  // Instantiate the ALU module
  alu uut (
    .a(a),
    .b(b),
    .op(alu_op),
    .result(result)
  );

  // Initialize the inputs
  initial begin
    a = 10;
    b = 5;
    alu_op = 0; // Set the ALU operation to ADD
    #10; // Wait for 10 time units
    $display("Result of ADD operation: %d", result);

    a = 10;
    b = 5;
    alu_op = 1; // Set the ALU operation to SUB
    #10; // Wait for 10 time units
    $display("Result of SUB operation: %d", result);

    // Add more test cases for other ALU operations
    // ...

    $finish; // End the simulation
  end
endmodule