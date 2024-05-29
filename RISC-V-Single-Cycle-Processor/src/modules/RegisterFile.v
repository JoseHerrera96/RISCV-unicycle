module RegisterFile (
  input wire [4:0] rs1,
  input wire [4:0] rs2,
  input wire [4:0] rd,
  input wire regWrite,
  input wire clk,
  input wire reset,
  output wire [31:0] readData1,
  output wire [31:0] readData2
);

  reg [31:0] registers [31:0];

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      registers <= 0;
    end else if (regWrite) begin
      registers[rd] <= readData2;
    end
  end

  assign readData1 = registers[rs1];
  assign readData2 = registers[rs2];

endmodule