module sign_extender_test;
    // Testbench code for the Sign Extender module

    // Include the Sign Extender module
    `include "../src/sign_extender.v"

    // Define the module inputs and outputs
    reg [31:0] input;
    wire [31:0] output;

    // Instantiate the Sign Extender module
    sign_extender dut (
        .input(input),
        .output(output)
    );

    // Initialize the input value
    initial begin
        input = 16'hFFFF; // Example immediate value
        #10;
        $finish;
    end

    // Display the output value
    always @(output) begin
        $display("Output: %h", output);
    end
endmodule