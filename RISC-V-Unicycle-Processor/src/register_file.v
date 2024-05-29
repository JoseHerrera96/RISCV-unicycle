module register_file (
  input wire [4:0] rs1,
  input wire [4:0] rs2,
  input wire [4:0] rd,
  input wire [31:0] write_data,
  input wire reg_write,
  output wire [31:0] read_data1,
  output wire [31:0] read_data2
);

  reg [31:0] registers [0:31];

  always @*
  begin
    read_data1 = registers[rs1];
    read_data2 = registers[rs2];
  end

  always @(posedge clk)
  begin
    if (reg_write)
      registers[rd] <= write_data;
  end

endmodule