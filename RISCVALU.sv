module RISCVALU(ALUctl, A, B, ALUout, zero);

    input logic [3:0] ALUctl;
    input logic [31:0] A, B;
    output logic signed [31:0] ALUout;
    output logic zero=0;

   // assign zero = (ALUout==0);

    always @(A or B) begin
        $display("A: %d", A);
        $display("B: %d", B);
        $display("ALUctl: %b", ALUctl);
        case(ALUctl)

            0: ALUout = A&B;
            1: ALUout = A|B;
            2: ALUout = A+B;
            6: ALUout = A-B;                
            7: ALUout = A<B ? 1:0;
            12: ALUout = ~(A|B);
            default: ALUout <= 0;

        endcase

    
        if (ALUctl==6)begin 
            if (ALUout==0)
                zero = 1;
        end
    end
endmodule