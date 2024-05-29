module instruction_memory_test;
  // Testbench code for the Instruction Memory module

  // Include the required libraries
  `include "instruction_memory.v"

  // Declare signals for the testbench
  reg [31:0] address;
  reg [31:0] instruction;
  wire [31:0] fetched_instruction;

  // Instantiate the Instruction Memory module
  instruction_memory uut (
    .address(address),
    .instruction(instruction),
    .fetched_instruction(fetched_instruction)
  );

  // Initialize the signals
  initial begin
    address = 0;
    instruction = 32'h00000000;

    // Read the instruction at address 0
    #10;
    address = 0;
    #10;
    $display("Fetched instruction at address 0: %h", fetched_instruction);

    // Read the instruction at address 4
    #10;
    address = 4;
    #10;
    $display("Fetched instruction at address 4: %h", fetched_instruction);

    // Read the instruction at address 8
    #10;
    address = 8;
    #10;
    $display("Fetched instruction at address 8: %h", fetched_instruction);

    // Read the instruction at address 12
    #10;
    address = 12;
    #10;
    $display("Fetched instruction at address 12: %h", fetched_instruction);

    // Read the instruction at address 16
    #10;
    address = 16;
    #10;
    $display("Fetched instruction at address 16: %h", fetched_instruction);

    // Read the instruction at address 20
    #10;
    address = 20;
    #10;
    $display("Fetched instruction at address 20: %h", fetched_instruction);

    // Read the instruction at address 24
    #10;
    address = 24;
    #10;
    $display("Fetched instruction at address 24: %h", fetched_instruction);

    // Read the instruction at address 28
    #10;
    address = 28;
    #10;
    $display("Fetched instruction at address 28: %h", fetched_instruction);

    // Finish the simulation
    #10;
    $finish;
  end
endmodule