`timescale 1us/1ns
`include "instmemory.v"
`include "registerfile.v"
`include "RISCVALU.v"
`include "datamem.v"
`include "signext.v"
`include "PC.v"

module RISCVunicycle(clock,rst,finish_flag);

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
    reg mem_read, mem_write,regenb;
    reg [31:0] addrs,datainmemory, outp;
    wire [31:0] dout;
    wire zero;
    reg [31:0]alu_src;
    reg busy = 0; // Señal de control para evitar ejecución simultánea
    reg decode_done, alu_ready, aluSrc_cntrl_ready;
    wire last_instr_flag; // Bandera para indicar que el programa ha terminado
    output reg finish_flag; // Bandera para indicar que el programa ha terminado
    // modulos

    PC modPC(
        .clk(clock),
        .reset(rst),
        .pc_reg(pc_out),
        .finish_flag(finish_flag)
    );
    instmemory modInstm(
        .addr(instaddr),
        .instruct(instruct),
        .last_instr_flag(last_instr_flag)
    );
    registerfile modregfile(
        .Read1(R1),
        .Read2(R2),
        .Data1(D1),
        .Data2(D2),
        .RD(Rd),
        .clock(clock),
        .RegWrite(regenb),
        .WriteData(dataregin),
        .finish_flag(finish_flag)
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

    always @ (posedge rst) begin // Bloque de reset
    if (!busy) begin
        busy = 1; // Marca el bloque como ocupado
        if (rst == 1) begin
            R1 = 5'd0; // Reset de señales
            R2 = 5'd0;
            Rd = 5'd0;
            instaddr = 32'd0;
            opcode = 7'd0;
            funct3 = 7'd0;
            Aluin1 = 32'd0;
            Aluin2 = 32'd0;
            imm = 12'd0;
            alu_op = 4'd0;
            mem_read = 0; 
            mem_write = 0;
            addrs = 32'd0;
            datainmemory = 32'd0;
            alu_src = 32'd0;
            regenb = 0;
            decode_done = 0; 
            alu_ready = 0;  
            aluSrc_cntrl_ready = 0; 
            finish_flag=0;
            $display("reset done");
        end
        busy = 0; // Libera el bloqueo
    end
    end
    // decoder
    always @(pc_out) begin
        if (!busy && !rst && !finish_flag) begin
            busy = 1; // Marca el bloque como ocupado
            // Decodificación de la instrucción
            $display(" ");
            $display("PC: %d", pc_out);
            instaddr = pc_out;
            opcode = instruct[6:0];
            R1 = instruct[19:15];
            $display("Instrucion: %h", instruct);
            $display("opcode: %b", opcode);
            regenb = 0;
            mem_read = 0;

            case (opcode)
                7'b0110011: begin // Tipo R
                    R2 = instruct[24:20];
                    funct3 = instruct[14:12];
                    Rd = instruct[11:7];
                    funct7 = instruct[31:25];
                    $display("funct3: %b", funct3);
                    case (funct3)
                        3'b111: alu_op = 0; // AND
                        3'b110: alu_op = 1; // OR
                        3'b000: begin
                            case (funct7)
                                7'b0000000: alu_op = 2; // ADD
                                7'b0100000: alu_op = 6; // SUB
                            endcase
                        end
                    endcase
                    $display("R1: %d", R1);
                    $display("R2: %d", R2);
                    $display("D1: %d", D1);
                    $display("D2: %d", D2);
                    $display("tipo R");
                end
                7'b0010011: begin // Tipo I
                    Rd = instruct[11:7];
                    funct3 = instruct[14:12];
                    $display("funct3: %b", funct3);
                    case (funct3)
                        3'b111: alu_op = 0; // ANDI
                        3'b110: alu_op = 1; // ORI
                        3'b000: alu_op = 2; // ADDI
                    endcase
                    $display("R1: %d", R1);
                    $display("D1: %d", D1);

                    $display("tipo I");
                end
                7'b0000011: begin // Load Word (LW)
                    alu_op = 3'b000;
                    $display("tipo L");
                end
                7'b0100011: begin // Store Word (SW)
                    alu_op = 3'b000;
                    $display("tipo S");
                end
            endcase

            $display("alu_op: %b", alu_op);
            decode_done = 1; // Indicar que el decode ha terminado
            busy = 0; // Libera el bloqueo
        end
    end

    always @(posedge decode_done) begin
        decode_done = 0; // Reinicia la señal de control
        case (opcode)
                7'b0110011: begin // Tipo R
                    regenb = 1; // Habilitar escritura en registro
                    alu_src = D2; // Usar registro como entrada de la ALU
                end
                7'b0010011: begin // Tipo I
                    regenb = 1;
                    alu_src = ext_imm; // Usar inmediato como entrada de la ALU
                    $display("ext_imm: %d", ext_imm);
                end
                7'b0000011: begin // Load Word (LW)
                    regenb = 1;
                    mem_read = 1;
                    alu_src = ext_imm; // Usar inmediato como entrada de la ALU
                    $display("ext_imm: %d", ext_imm);
                end
                7'b0100011: begin // Store Word (SW)
                    mem_write = 1;
                    alu_src = ext_imm; // Usar inmediato como entrada de la ALU
                    $display("ext_imm: %d", ext_imm);
                end
        endcase
        aluSrc_cntrl_ready = 1; // Indicar que el control de la ALU está listo
     end


    // Modificación del bloque actual para activar alu_ready
    always @(posedge aluSrc_cntrl_ready) begin
        aluSrc_cntrl_ready = 0; // Reinicia la señal de control
        if (!last_instr_flag) begin
            // Ejecución de la operación en la ALU
            $display("Ejecutando operacion en la ALU");
            // Configuración de las entradas de la ALU
            Aluin1 = D1; // Entrada 1 de la ALU (desde el registerfile)
            Aluin2 = alu_src; // Entrada 2 de la ALU (desde el registerfile o ext_imm)
            $display("Aluin1: %d", Aluin1);
            $display("Aluin2: %d", Aluin2);
        end

        alu_ready = 1; // Indicar que la ALU está lista para ejecutarse
    end

    // Nuevo módulo always para la ALU
    always @(posedge alu_ready) begin
        alu_ready = 0; // Reinicia la señal de control
        if (!last_instr_flag) begin
            // La salida de la ALU ya está conectada a ALUout a través del módulo RISCVALU
            $display("Resultado de la ALU: %d", ALUout);

            // Control de flujo posterior a la ALU
            if (mem_read) begin
                addrs = ALUout; // Dirección para lectura de memoria
                $display("Leyendo de memoria en direccion: %d", addrs);
            end else if (mem_write) begin
                addrs = ALUout; // Dirección para escritura en memoria
                datainmemory = D2; // Datos a escribir en memoria
                $display("Escribiendo en memoria en direccion: %d, valor: %d", addrs, datainmemory);
            end else begin
                dataregin = ALUout; // Resultado de la ALU para escritura en el registro destino
                $display("Resultado listo para escritura en registro: %d", dataregin);
            end
        end
    end

    always @(posedge last_instr_flag) begin
        if (last_instr_flag==1) begin
            $display("Program finished. Last instruction reached.");
            finish_flag=1;
            decode_done = 0; 
            alu_ready = 0; 
            aluSrc_cntrl_ready = 0;
            $finish; // Terminar la simulación
        end

    end
endmodule