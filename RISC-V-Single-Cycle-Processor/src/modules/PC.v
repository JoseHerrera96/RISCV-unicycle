module PC (
  input wire clk,
  input wire reset,
  output reg [31:0] pc
);

  always @(posedge clk or posedge reset) begin
    if (reset)
      pc <= 32'h0;
    else
      pc <= pc + 32'h4;
  end

endmodule