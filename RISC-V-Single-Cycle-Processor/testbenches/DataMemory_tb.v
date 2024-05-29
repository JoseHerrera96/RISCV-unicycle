`timescale 1ns / 1ps

module DataMemory_tb;

  // Inputs
  reg [31:0] address;
  reg [31:0] writeData;
  reg writeEnable;
  reg readEnable;

  // Outputs
  wire [31:0] readData;

  // Instantiate the DataMemory module
  DataMemory dut (
    .address(address),
    .writeData(writeData),
    .writeEnable(writeEnable),
    .readEnable(readEnable),
    .readData(readData)
  );

  // Clock generation
  reg clock;
  always #5 clock = ~clock;

  // Testbench logic
  initial begin
    // Initialize inputs
    address = 32'h00000000;
    writeData = 32'h12345678;
    writeEnable = 1;
    readEnable = 1;

    // Wait for a few clock cycles
    #10;

    // Print initial values
    $display("Initial values:");
    $display("Address: %h", address);
    $display("Write Data: %h", writeData);
    $display("Write Enable: %b", writeEnable);
    $display("Read Enable: %b", readEnable);
    $display("");

    // Perform a read operation
    address = 32'h00000004;
    writeEnable = 0;
    #10;

    // Print read result
    $display("Read result:");
    $display("Address: %h", address);
    $display("Read Data: %h", readData);
    $display("");

    // Perform a write operation
    address = 32'h00000008;
    writeData = 32'h87654321;
    writeEnable = 1;
    #10;

    // Print write result
    $display("Write result:");
    $display("Address: %h", address);
    $display("Write Data: %h", writeData);
    $display("");

    // Perform another read operation
    address = 32'h00000008;
    writeEnable = 0;
    #10;

    // Print read result
    $display("Read result:");
    $display("Address: %h", address);
    $display("Read Data: %h", readData);
    $display("");

    // Finish simulation
    $finish;
  end

  // Clock driver
  always #5 clock = ~clock;

endmodule