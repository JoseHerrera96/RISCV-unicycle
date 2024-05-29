`timescale 1ns / 1ps

module RegisterFile_tb;

  // Inputs
  reg [4:0] read_reg1;
  reg [4:0] read_reg2;
  reg [4:0] write_reg;
  reg [31:0] write_data;
  reg clk;
  reg reset;

  // Outputs
  wire [31:0] read_data1;
  wire [31:0] read_data2;

  // Instantiate the RegisterFile module
  RegisterFile register_file (
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

  // Testbench logic
  initial begin
    // Test case 1: Write data to register 1 and read from it
    write_reg = 1;
    write_data = 32'h12345678;
    read_reg1 = 1;
    read_reg2 = 0;
    #20;
    $display("Read data from register 1: %h", read_data1);

    // Test case 2: Write data to register 2 and read from it
    write_reg = 2;
    write_data = 32'h87654321;
    read_reg1 = 0;
    read_reg2 = 2;
    #20;
    $display("Read data from register 2: %h", read_data2);

    // Test case 3: Write data to register 3 and read from it
    write_reg = 3;
    write_data = 32'hABCDEF01;
    read_reg1 = 0;
    read_reg2 = 3;
    #20;
    $display("Read data from register 3: %h", read_data2);

    // Add more test cases as needed

    $finish;
  end

endmodule