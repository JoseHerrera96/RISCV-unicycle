module signext(instruct,out,typ);

input [31:0]instruct;
reg [11:0] in, inL, inS;
input [6:0] typ;
output reg [31:0] out;
// Extensión de signo
always @(*) begin

    inL<={{20{1'b1}},instruct[31:25],instruct[11:7]};
    inS<={{20{1'b1}},instruct[31],instruct[7],instruct[30:25],instruct[11:8]};
    in<={{20{1'b1}},instruct[31:20]};
    

    //in=instruct[31:20];
    
    case(typ)
    
        7'b0010011: begin
                out <= in; // Itype
                end
        7'b0000011: begin
                
                out <= inL; // Ltype
                end
        7'b0100011:begin
                
                out <= inS; // Stype
                end
    endcase

     end
endmodule