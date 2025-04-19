module signext(instruct,out,typ);

input [31:0]instruct;
reg [11:0] in, inL, inS;
input [6:0] typ;
output reg [31:0] out;

always @(instruct) begin
    case(typ)
        7'b0010011: begin
                in = {{20{instruct[31]}}, instruct[31:20]}; // Tipo I
                out = in; // Itype
                $display("Itype: %d", in);
                end
        7'b0000011: begin
                inL = {{20{instruct[31]}}, instruct[31:25], instruct[11:7]}; // Tipo L
                out = inL; // Ltype
                $display("Ltype: %d", inL);
                end
        7'b0100011:begin
                inS = {{20{instruct[31]}}, instruct[31], instruct[7], instruct[30:25], instruct[11:8]}; // Tipo S
                out = inS; // Stype
                $display("Stype: %d", inS);
                end
    endcase

     end
endmodule