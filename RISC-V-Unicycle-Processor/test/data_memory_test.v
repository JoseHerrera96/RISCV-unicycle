module data_memory_test;

  // Testbench code for the Data Memory module

  // Include the Data Memory module
  `include "../src/data_memory.v"

  // Define the testbench module
  module tb_data_memory;

    // Instantiate the Data Memory module
    data_memory dut();

    // Define the testbench signals
    reg [31:0] address;
    reg [31:0] write_data;
    reg [31:0] read_data;
    reg write_enable;
    reg read_enable;

    // Initialize the testbench signals
    initial begin
      address = 0;
      write_data = 0;
      read_data = 0;
      write_enable = 0;
      read_enable = 0;

      // Write data to memory
      address = 0;
      write_data = 123;
      write_enable = 1;
      #10;

      // Read data from memory
      address = 0;
      read_enable = 1;
      #10;

      // Check the read data
      if (read_data === write_data)
        $display("Data Memory Test Passed");
      else
        $display("Data Memory Test Failed");

      // End the simulation
      $finish;
    end

    // Connect the testbench signals to the Data Memory module
    always @(posedge dut.clk) begin
      dut.address <= address;
      dut.write_data <= write_data;
      dut.write_enable <= write_enable;
      dut.read_enable <= read_enable;
      read_data <= dut.read_data;
    end

  endmodule

  // Instantiate the testbench module
  tb_data_memory tb();

endmodule