`timescale 1us/1ns
`include "instmemory.v"
`include "registerfile.v"
`include "RISCVALU.v"
`include "datamem.v"
`include "signext.v"
`include "PC.v"
module RISCVunicycle(clk,reset);

    input wire clk;
    input wire reset;
    wire [31:0] PC, D1, D2;
    reg[31:0] Aluin1, Aluin2;
    reg [5:0] R1,R2,Rd;
    wire [31:0] ALUout;
    wire[31:0] instruct, pc_reg;
    reg [11:0] imm; 
    wire [31:0] ext_imm;
    reg [6:0] opcode, funct3;
    reg [3:0] alu_op;
    reg mem_read, mem_write;
    reg [31:0] addrs,datainmemory;
    wire [31:0] dout;
    wire zero;
    reg [31:0]alu_src;
    
    // modulos

    PC modPC(
    .clk(clk),
    .reset(reset),
    .pc_reg(pc_reg) 
    );
    instmemory modInstm(
        .addr(pc_reg),
        .instruct(instruct)
    );
    registerfile modregfile(
        .Read1(R1),
        .Read2(R2),
        .Data1(D1),
        .Data2(D2),
        .RD(Rd),
        .clock(clk)
    );
    RISCVALU modalu(
        .ALUctl(alu_op),
        .A(Aluin1),
        .B(Aluin2),
        .ALUout(ALUout),
        .zero(zero)
    );
    DataMemory modmemory(
    .clk(clk),
    .write_enable(mem_write),
    .read_enable(mem_read),
    .address(addrs),
    .write_data(datainmemory),
    .read_data(dout)
    );
    signext extensorS(
    .in(imm),
    .out(ext_imm)
    );


    initial begin
        $dumpfile("RISCVunicycle.vcd");
        $dumpvars(0, RISCVunicycle);
    end

    always @ (posedge clk or posedge reset) begin
        
        if (reset) begin
            R1=0;// Reset de señales
        end 
        else begin
            // Decodificación de la instrucción
            opcode <= instruct[6:0];
            funct3 <= instruct[14:12];
            R1 <= instruct[19:15];
            R2 <= instruct[24:20];
            Rd <= instruct[11:7];
            imm <= instruct[31:20];
            case (opcode)
                7'b0110011: alu_op <= funct3; // Rtype
                7'b0010011: alu_op <= funct3; // Itype
                7'b0000011: alu_op <= 3'b000; // Load Word
                7'b0100011: alu_op <= 3'b000; // Store Word
                default: alu_op <= 3'b000; 
            endcase
            mem_read <= (opcode == 7'b0000011) ? 1'b1 : 1'b0; // Load Word
            mem_write <= (opcode == 7'b0100011) ? 1'b1 : 1'b0; // Store Word
        end
    end
        
    always @(*) begin
        Aluin1 = D1;
        Aluin2 = alu_src;
    end

    always @(*) begin
        if (opcode == 7'b0110011) begin
            alu_src = ext_imm;
        end 
        else begin
            alu_src = R2;
        end
    end

endmodule