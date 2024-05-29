module DataMemory (
  input wire [31:0] address,
  input wire [31:0] writeData,
  input wire writeEnable,
  input wire readEnable,
  output wire [31:0] readData
);
  reg [31:0] memory [0:1023];

  always @(posedge clk) begin
    if (writeEnable) begin
      memory[address] <= writeData;
    end
    if (readEnable) begin
      readData <= memory[address];
    end
  end
endmodule