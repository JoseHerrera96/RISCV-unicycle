`timescale 1us/1ns
`include "instmemory.sv"
`include "registerfile.sv"
`include "RISCVALU.sv"
`include "datamem.sv"
`include "signext.sv"
`include "PC.sv"

module RISCVunicycle(clock,rst,finish_flag);

    input logic clock;
    input logic rst;
    logic [31:0] PC, D1, D2;
    logic[31:0] Aluin1,Aluin2;
    logic signed [31:0] dataregin;
    logic [4:0] R1,R2,Rd;
    logic signed [31:0] ALUout;
    logic[31:0] instruct; 
    logic signed [31:0] pc_out;
    logic signed [11:0] imm; 
    logic signed [31:0] ext_imm;
    logic [6:0] opcode, funct7;
    logic [3:0] funct3;
    logic [3:0] alu_op;
    logic mem_read, mem_write,regenb,branch;
    logic [31:0] addrs, outp;
    logic signed [31:0] datainmemory;
    logic signed [31:0] dout;
    logic zero;
    logic [31:0]alu_src;
    logic busy = 0; // Señal de control para evitar ejecución simultánea
    logic decode_done, alu_ready, aluSrc_cntrl_ready, lw_data_ready, decode_begin; // Señales de control para la ejecución
    logic last_instr_flag; // Bandera para indicar que el programa ha terminado
    output logic finish_flag; // Bandera para indicar que el programa ha terminado
    logic signed [31:0] branch_offset; // Desplazamiento para el salto condicional
    // modulos

    PC modPC(
        .clk(clock),
        .reset(rst),
        .pc_reg(pc_out),
        .finish_flag(finish_flag),
        .branch(branch),
        .branch_offset(branch_offset)
    );
    instmemory modInstm(
        .addr(pc_out),
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
        .out(ext_imm)
    );

    always @ (posedge rst) begin // Bloque de reset
    if (!busy) begin
        busy = 1; // Marca el bloque como ocupado
        if (rst == 1) begin
            R1 = 5'd0; // Reset de señales
            R2 = 5'd0;
            Rd = 5'd0;
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
            branch = 0;
            branch_offset = 32'd0; // Inicializa el desplazamiento de salto
            lw_data_ready = 0; // Inicializa la bandera de última instrucción
            decode_begin = 0; // Inicializa la bandera de decodificación
            $display("reset done");
        end
        busy = 0; // Libera el bloqueo
    end
    end
    always @(pc_out) begin
        if (lw_data_ready) begin
            lw_data_ready = 0; // Reinicia la señal de control
            regenb = 1;
            dataregin = dout; // Cargar datos desde la memoria
            $display("Cargando datos desde memoria: %d", dataregin);
        end
        decode_begin = 1; // Indica que la decodificación ha comenzado
    end
    // decoder
    always @(posedge decode_begin) begin
        regenb = 0;
        mem_read = 0;
        branch = 0;
        mem_write = 0;
        decode_begin = 0; // Reinicia la señal de control
        
        if (!busy && !rst && !finish_flag) begin
            busy = 1; // Marca el bloque como ocupado
            // Decodificación de la instrucción
            $display(" ");
            $display("PC: %d", pc_out);
            opcode = instruct[6:0];
            R1 = instruct[19:15];
            $display("Instrucion: %h", instruct);
            $display("opcode: %b", opcode);
    

            case (opcode)
                7'b0110011: begin // Tipo R
                    $display("tipo R");
                    R2 = instruct[24:20];
                    funct3 = instruct[14:12];
                    Rd = instruct[11:7];
                    funct7 = instruct[31:25];
                    $display("funct3: %b", funct3);
                    $display("Registro destino: %d", Rd);
                    case (funct3)
                        3'b111: begin
                            alu_op = 0; // AND
                                $display("AND");
                        end
                        3'b110:begin
                                alu_op = 1; // OR
                                $display("OR");
                        end
                        3'b000: begin
                            case (funct7)
                                7'b0000000:begin
                                alu_op = 2; // ADD
                                $display("ADD");
                                end
                                7'b0100000:begin
                                alu_op = 6; // SUB
                                $display("SUB");
                                end
                            endcase
                        end
                    endcase
                    $display("R1: %d", R1);
                    $display("R2: %d", R2);
                    $display("D1: %d", D1);
                    $display("D2: %d", D2);
                end
                7'b0010011: begin // Tipo I
                    $display("tipo I");
                    Rd = instruct[11:7];
                    funct3 = instruct[14:12];
                    imm = instruct[31:20]; // Inmediato
                    $display("Registro destino: %d", Rd);
                    $display("funct3: %b", funct3);
                    case (funct3)
                        3'b111: begin
                            alu_op = 0; // ANDI
                            $display("ANDI");
                        end
                        3'b110: begin
                            alu_op = 1; // ORI
                            $display("ORI");
                        end
                        3'b000: begin
                            alu_op = 2; // ADDI
                            $display("ADDI");
                        end
                    endcase
                    $display("R1: %d", R1);
                    $display("D1: %d", D1);
                end
                7'b0000011: begin // Load Word (LW)
                    $display("Load word");
                    Rd = instruct[11:7];
                    imm = instruct[31:20]; // Inmediato
                    alu_op = 3'b010;
                    $display("Registro destino: %d", Rd);
                end
                7'b0100011: begin // Store Word (SW)
                    $display("store word");
                    imm = {instruct[31], instruct[30:25], instruct[11:7]}; // Inmediato
                    alu_op = 3'b010;
                end
                7'b1100011: begin // Branch (BEQ)
                    $display("branch?");
                    alu_op = 6;
                    R2 = instruct[24:20];
                    funct3 = instruct[14:12];
                    imm = {{20{instruct[31]}}, instruct[31], instruct[7], instruct[30:25], instruct[11:9],1'b0}; // Inmediato
                    branch_offset = ext_imm; // Guardar el desplazamiento de salto
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
                    $display("imm: %d", imm);
                    $display("ext_imm: %d", ext_imm);
                end
                7'b0000011: begin // Load Word (LW)
                    regenb = 1;
                    mem_read = 1;
                    alu_src = ext_imm; // Usar inmediato como entrada de la ALU
                    $display("imm: %d", imm);
                    $display("ext_imm: %d", ext_imm);
                end
                7'b0100011: begin // Store Word (SW)
                    mem_write = 1;
                    alu_src = ext_imm; // Usar inmediato como entrada de la ALU
                    $display("imm: %d", imm);
                    $display("ext_imm: %d", ext_imm);
                end
                7'b1100011: begin // Branch (BEQ)
                    alu_src = D2; // Usar registro como entrada de la ALU
                    $display("imm: %d", imm);
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
                lw_data_ready = 1; // Indicar que los datos de carga están listos
                addrs = ALUout; // Dirección para lectura de memoria
                $display("Leyendo de memoria en direccion: %d", addrs);
            end else if (mem_write) begin
                addrs = ALUout; // Dirección para escritura en memoria
                datainmemory = D2; // Datos a escribir en memoria
                $display("Escribiendo en memoria en direccion: %d", addrs);
                $display("Datos a escribir en memoria: %d", datainmemory);
            end else begin
                dataregin = ALUout; // Resultado de la ALU para escritura en el registro destino
                $display("Resultado listo para escritura en registro: %d", dataregin);
            end

            if (zero==1 && opcode==7'b1100011) begin
                branch = 1; // Activar el salto si la condición se cumple
                $display("Branch taken, jumping to address: %d", pc_out + branch_offset);
            end 
            else begin
                    $display("continuing to next instruction.");
                end
        end
    end

    always @(posedge last_instr_flag) begin
        if (last_instr_flag==1) begin
            $display("Esta es la ultima instruccion, terminando la simulacion.");
            finish_flag=1;
            decode_done = 0; 
            alu_ready = 0; 
            aluSrc_cntrl_ready = 0;
            $finish; // Terminar la simulación
        end

    end
endmodule