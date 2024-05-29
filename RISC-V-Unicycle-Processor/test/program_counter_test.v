module program_counter_test;
  // Testbench code for the Program Counter module

  // Include the Program Counter module
  `include "../src/program_counter.v"

  // Define the clock and reset signals
  reg clk;
  reg reset;

  // Instantiate the Program Counter module
  program_counter pc (
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out)
  );

  // Define the output signal
  reg [31:0] pc_out;

  // Initialize the clock and reset signals
  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
  end

  // Toggle the clock signal
  always #5 clk = ~clk;

  // Print the value of the program counter
  always @(posedge clk) begin
    $display("Program Counter: %h", pc_out);
  end

  // End the simulation
  initial begin
    #100 $finish;
  end
endmodule