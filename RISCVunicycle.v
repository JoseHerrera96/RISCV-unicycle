`timescale 1us/1ns
`include "instmemory.v"
`include "registerfile.v"
`include "RISCVALU.v"
`include "datamem.v"
`include "signext.v"
`include "PC.v"

module RISCVunicycle(clock,rst);

    input wire clock;
    input wire rst;
    wire [31:0] PC, D1, D2;
    reg[31:0] Aluin1,Aluin2,instaddr,dataregin;
    reg [4:0] R1,R2,Rd;
    wire [31:0] ALUout;
    wire[31:0] instruct, pc_out;
    reg [11:0] imm; 
    wire [31:0] ext_imm;
    reg [6:0] opcode, funct7;
    reg [3:0] funct3;
    reg [3:0] alu_op;
    reg mem_read, mem_write,regenb,pcnext;
    reg [31:0] addrs,datainmemory, outp;
    wire [31:0] dout;
    wire zero;
    reg [31:0]alu_src;
    
    // modulos

    PC modPC(
        .clk(clock),
        .reset(rst),
        .pc_reg(pc_out),
        .pcnext(pcnext) 
    );
    instmemory modInstm(
        .addr(instaddr),
        .instruct(instruct)
    );
    registerfile modregfile(
        .Read1(R1),
        .Read2(R2),
        .Data1(D1),
        .Data2(D2),
        .RD(Rd),
        .clock(clock),
        .RegWrite(regenb),
        .WriteData(dataregin)
    );
    RISCVALU modalu(
        .ALUctl(alu_op),
        .A(Aluin1),
        .B(Aluin2),
        .ALUout(ALUout),
        .zero(zero)
    );
    DataMemory modmemory(
        .clk(clock),
        .write_enable(mem_write),
        .read_enable(mem_read),
        .address(addrs),
        .write_data(datainmemory),
        .read_data(dout)
    );
    signext extensorS(
        .instruct(instruct),
        .out(ext_imm),
        .typ(opcode)
    );
  

    always @ (posedge rst) begin //control
        
        if (rst==1) begin
            pcnext<=0;
            R1=5'd0;// Reset de señales
            R2=5'd0;
            Rd=5'd0;
            instaddr=32'd0;
            opcode=7'd0;
            funct3=7'd0;
            Aluin1=32'd0;
            Aluin2=32'd0;
            imm=12'd0;
            alu_op=4'd0;
            mem_read=0; 
            mem_write=0;
            addrs=32'd0;
            datainmemory=32'd0;
            alu_src=32'd0;
            regenb=0;
            $display("reset done");
        end 
    end

    always @(pc_out) begin
        // Decodificación de la instrucción
        $display("PC: %d", pc_out);
        instaddr = pc_out;
        opcode = instruct[6:0];
        funct3 = instruct[14:12];
        R1 = instruct[19:15];
        R2 = instruct[24:20];
        Rd = instruct[11:7];
        $display("Instrucion: %h",instruct);
        $display("R1: %b",R1);
        $display("R2: %b",R2);
        $display("D1: %d", D1);
        $display("D2: %d", D2);
        $display("opcode: %b", opcode);
        regenb=0;
        mem_read=0;
        case (opcode)
        7'b0110011: begin 
            alu_op = funct3; // Rtype
            funct7 = instruct[31:25];
            case(funct3)
            3'b111:
                alu_op = 0;
            3'b110:
                alu_op = 1;
            3'b000:
                case(funct7)
                7'b0000000:
                    alu_op = 2;
                7'b0100000:
                    alu_op = 6;
                endcase
            endcase

            regenb = 1;
            $display("tipo R");
            end
        7'b0010011: begin
            alu_op = funct3; // Itype
            regenb = 1;
            end            
        7'b0000011: begin
            alu_op =3'b000; // Load Word
            regenb = 1;
            end
        7'b0100011: alu_op = 3'b000; // Store Word                 
            //default: alu_op <= 3'b000; 
        endcase
        $display("alu_op: %b", alu_op);
    end
    
    always @(opcode) begin//ALU control
        if ((opcode == 7'b0010011)||(opcode == 7'b0000011)||(opcode == 7'b0100011)) begin
            alu_src = ext_imm;
        end 

        else begin
            alu_src = D2;
            $display("ALU control done");
        end
    end
    always @(D1 or alu_src) begin
        Aluin1 = D1;
        Aluin2 = alu_src;
        $display("Aluin1: %d", Aluin1);
        $display("Aluin2: %d", Aluin2);
    end
    always @(*) begin;
        if (mem_read==1)begin
            outp=dout;
        end
        else begin
            outp=ALUout;
        end
        dataregin=outp;
        $display("entrada de datos: %d", dataregin);
            
    end
endmodule