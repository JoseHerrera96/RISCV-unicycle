module signext(in,out);

input wire [11:0] in;
output reg [31:0] out;
// Extensión de signo
always @*
begin
    if (in[11] == 1'b1)
        out = {{20{1'b1}}, in};
    else
        out = {{20{1'b0}}, in};
end
endmodule