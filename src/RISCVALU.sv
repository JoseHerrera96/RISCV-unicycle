module RISCVALU(ALUctl, A, B, ALUout, zero, reset_zero_flag);

    input logic [3:0] ALUctl;
    input logic [31:0] A, B;
    output logic signed [31:0] ALUout;
    output logic zero=0;
    input logic reset_zero_flag;

   // assign zero = (ALUout==0);

    always @(A or B or ALUctl) begin
        $display("A: %d", A);
        $display("B: %d", B);
        $display("ALUctl: %b", ALUctl);
        case(ALUctl)
            0: ALUout = A & B;       // AND/ANDI
            1: ALUout = A | B;       // OR/ORI
            2: ALUout = A + B;       // ADD/ADDI
            6: ALUout = A - B;       // SUB
            7: ALUout = ($signed(A) < $signed(B)) ? 1 : 0; // SLT/SLTI
            8: ALUout = A << B[4:0]; // SLL/SLLI
            9: ALUout = A >> B[4:0]; // SRL/SRLI
            10: ALUout = $signed(A) >>> B[4:0]; // SRA/SRAI
            11: ALUout = (A < B) ? 1 : 0; // SLTU/SLTIU (unsigned)
            12: ALUout = ~(A | B);   // NOR
            default: ALUout = 0;
        endcase
        // Zero flag for branches
        if (ALUctl == 6) begin // SUB for BEQ/BNE/BLT/BGE
            zero = (ALUout == 0) ? 1 : 0;
        end else begin
            zero = 0;
        end
    end

    always @(posedge reset_zero_flag) begin
        zero = 0;
    end

endmodule