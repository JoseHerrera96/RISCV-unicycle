module data_memory (
  input clk,
  input wire [31:0] address,
  input wire [31:0] write_data,
  input wire write_enable,
  input wire read_enable,
  output reg [31:0] read_data
);
  reg [31:0] memory [0:1023];
  
  always @(posedge clk) begin
    if (write_enable) begin
      memory[address] <= write_data;
    end
    if (read_enable) begin
      read_data <= memory[address];
    end
  end
endmodule