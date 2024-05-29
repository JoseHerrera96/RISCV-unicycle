`timescale 1ns / 1ps

module PC_tb;

  // Inputs
  reg clk;
  reg reset;

  // Outputs
  wire [31:0] pc_out;

  // Instantiate the PC module
  PC pc (
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out)
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
    // Initialize inputs
    clk = 0;

    // Wait for reset to be deasserted
    @(negedge reset);

    // Test case 1: Check initial PC value
    if (pc_out !== 32'h00000000) begin
      $display("Test case 1 failed: Incorrect initial PC value");
    end

    // Test case 2: Check PC increment
    #10;
    if (pc_out !== 32'h00000004) begin
      $display("Test case 2 failed: Incorrect PC increment");
    end

    // Add more test cases here

    // End simulation
    $finish;
  end

endmodule