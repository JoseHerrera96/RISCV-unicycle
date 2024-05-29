// sign_extender.v

module sign_extender (
  input [31:0] immediate,
  output reg [31:0] extended_immediate
);

  always @(*) begin
    if (immediate[31] == 1) begin
      extended_immediate = { {16{immediate[31]}}, immediate[31:0] };
    end else begin
      extended_immediate = immediate;
    end
  end

endmodule
