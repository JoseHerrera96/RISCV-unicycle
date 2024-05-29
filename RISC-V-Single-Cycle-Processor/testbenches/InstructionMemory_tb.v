`timescale 1ns / 1ps

module InstructionMemory_tb;

  // Inputs
  reg clk;
  reg [31:0] address;

  // Outputs
  wire [31:0] instruction;

  // Instantiate the InstructionMemory module
  InstructionMemory dut (
    .clk(clk),
    .address(address),
    .instruction(instruction)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Testbench logic
  initial begin
    // Initialize inputs
    clk = 0;
    address = 0;

    // Wait for a few clock cycles
    #10;

    // Read instructions from memory
    address = 0;
    #5;
    address = 4;
    #5;
    address = 8;
    #5;

    // Finish simulation
    $finish;
  end

endmodule