module instruction_memory (
    input wire [31:0] address,
    output reg [31:0] instruction
);

    reg [31:0] memory [0:1023];

    initial begin
        // Initialize memory with instructions
        // Replace the instructions below with your own instructions
        memory[0] = 32'h00000000; // Example instruction 1
        memory[1] = 32'h00000000; // Example instruction 2
        // ...
    end

    always @(address) begin
        // Read instruction from memory based on address
        instruction = memory[address];
    end

endmodule