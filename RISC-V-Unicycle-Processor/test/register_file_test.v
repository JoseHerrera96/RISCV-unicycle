module register_file_test;
  // Testbench code for the Register File module

  // Include the Register File module
  `include "../src/register_file.v"

  // Define the testbench inputs and outputs
  reg [4:0] read_reg1, read_reg2, write_reg;
  reg [31:0] write_data;
  wire [31:0] read_data1, read_data2;
  reg clk, reset;

  // Instantiate the Register File module
  register_file dut (
    .clk(clk),
    .reset(reset),
    .read_reg1(read_reg1),
    .read_reg2(read_reg2),
    .write_reg(write_reg),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    reset = 1;
    #10 reset = 0;
  end

  // Test case 1: Write and read from register file
  initial begin
    // Set inputs
    read_reg1 = 1;
    read_reg2 = 2;
    write_reg = 3;
    write_data = 32'h12345678;

    // Wait for reset to complete
    #20;

    // Check initial values
    if (read_data1 !== 0 || read_data2 !== 0) begin
      $display("Test case 1 failed: Initial values are not zero");
      $finish;
    end

    // Write data to register file
    #10 write_data = 32'h87654321;

    // Read data from register file
    #10 read_reg1 = 3;
    #10 read_reg2 = 3;

    // Check read data
    if (read_data1 !== 32'h87654321 || read_data2 !== 32'h87654321) begin
      $display("Test case 1 failed: Read data does not match expected value");
      $finish;
    end

    $display("Test case 1 passed");
    $finish;
  end

  // Test case 2: Write and read from different registers
  initial begin
    // Set inputs
    read_reg1 = 4;
    read_reg2 = 5;
    write_reg = 6;
    write_data = 32'hABCDEF01;

    // Wait for reset to complete
    #20;

    // Check initial values
    if (read_data1 !== 0 || read_data2 !== 0) begin
      $display("Test case 2 failed: Initial values are not zero");
      $finish;
    end

    // Write data to register file
    #10 write_data = 32'hFEDCBA09;

    // Read data from register file
    #10 read_reg1 = 6;
    #10 read_reg2 = 6;

    // Check read data
    if (read_data1 !== 32'hFEDCBA09 || read_data2 !== 32'hFEDCBA09) begin
      $display("Test case 2 failed: Read data does not match expected value");
      $finish;
    end

    $display("Test case 2 passed");
    $finish;
  end

  // Test case 3: Write and read from the same register
  initial begin
    // Set inputs
    read_reg1 = 7;
    read_reg2 = 7;
    write_reg = 7;
    write_data = 32'h55555555;

    // Wait for reset to complete
    #20;

    // Check initial values
    if (read_data1 !== 0 || read_data2 !== 0) begin
      $display("Test case 3 failed: Initial values are not zero");
      $finish;
    end

    // Write data to register file
    #10 write_data = 32'hAAAAAAAA;

    // Read data from register file
    #10 read_reg1 = 7;
    #10 read_reg2 = 7;

    // Check read data
    if (read_data1 !== 32'hAAAAAAAA || read_data2 !== 32'hAAAAAAAA) begin
      $display("Test case 3 failed: Read data does not match expected value");
      $finish;
    end

    $display("Test case 3 passed");
    $finish;
  end

endmodule