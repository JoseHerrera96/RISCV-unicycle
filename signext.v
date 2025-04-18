module signext(instruct,out,typ);

input [31:0]instruct;
wire [11:0] in, inL, inS;
input [6:0] typ;
output reg [31:0] out;
// Extensión de signo para instrucciones de tipo I, L y S
assign inL = {{20{instruct[31]}}, instruct[31:25], instruct[11:7]}; // Tipo L
assign inS = {{20{instruct[31]}}, instruct[31], instruct[7], instruct[30:25], instruct[11:8]}; // Tipo S
assign in = {{20{instruct[31]}}, instruct[31:20]}; // Tipo I

always @(in, inL, inS) begin
    case(typ)
    
        7'b0010011: begin
                out <= in; // Itype
                $display("Itype: %d", in);
                end
        7'b0000011: begin
                out <= inL; // Ltype
                $display("Ltype: %d", inL);
                end
        7'b0100011:begin
                
                out <= inS; // Stype
                $display("Stype: %d", inS);
                end
    endcase

     end
endmodule