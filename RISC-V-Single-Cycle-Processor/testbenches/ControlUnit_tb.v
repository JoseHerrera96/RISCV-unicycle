`timescale 1ns / 1ps

module ControlUnit_tb;

  // Inputs
  reg clk;
  reg reset;

  // Outputs
  wire control_signal;

  // Instantiate the ControlUnit module
  ControlUnit dut (
    .clk(clk),
    .reset(reset),
    .control_signal(control_signal)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Reset generation
  initial begin
    reset = 1;
    #10 reset = 0;
  end

  // Testbench logic
  initial begin
    // Test case 1
    #20;
    // Add your test case logic here

    // Test case 2
    #20;
    // Add your test case logic here

    // Test case 3
    #20;
    // Add your test case logic here

    // Add more test cases as needed

    // End simulation
    #10 $finish;
  end

endmodule