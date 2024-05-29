// File: /RISC-V-Unicycle-Processor/src/program_counter.v

module program_counter (
  input wire clk,
  input wire reset,
  input wire enable,
  input wire [31:0] branch_address,
  output wire [31:0] pc_out
);

  reg [31:0] pc;

  always @(posedge clk or posedge reset) begin
    if (reset)
      pc <= 32'h0;
    else if (enable)
      pc <= branch_address;
    else
      pc <= pc + 4;
  end

  assign pc_out = pc;

endmodule
