module InstructionMemory (
  input wire [31:0] address,
  output wire [31:0] instruction
);
  // Define the memory contents
  reg [31:0] memory [0:1023];

  // Initialize the memory with instructions
  initial begin
    // Load instructions into memory
    // memory[0] = 32'h01234567;
    // memory[1] = 32'h89ABCDEF;
    // ...
  end

  // Read the instruction at the given address
  assign instruction = memory[address];

endmodule