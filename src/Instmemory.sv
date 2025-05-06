module instmemory(addr,instruct, last_instr_flag);
    input logic [31:0] addr; // Dirección de la instrucción actual
    output logic [31:0] instruct; // Instrucción actual
    logic [31:0] file [0:31]; 
    logic [7:0] RF [0:127]; // 128 espacios de 8 bits cada uno # 32 registros de 32 bits
    logic [31:0] instruct_temp, full_RF_temp; // Instrucción actual
    output logic last_instr_flag=0; // Bandera para indicar la última instrucción
    logic [31:0] d = 32'd0; // Inicializar el contador d correctamente

   initial begin

        for (integer i = 0; i < 128; i = i + 1) begin
            RF[i] = 8'hFF; // Inicializar registros a -1
        end
        for (integer j = 0; j < 32; j = j + 1) begin
            file[j] = 32'hFFFFFFFF; // Inicializar registros a -1
        end
        
        $readmemh("FinalT.hex", file);
        if (file[0] === 32'hFFFFFFFF) begin
            $display("Error: El archivo FinalT.hex está vacío o no tiene suficientes datos.");
            $finish;
        end

        
        instruct_temp = file[0]; // Leer la primera instrucción del archivo
        d = 32'd0; // Asegurar que d se inicialice antes del bucle
        for (integer i = 1; i < 32; i = i + 1) begin        
            RF[d] = instruct_temp[7:0]; // Mostrar el contenido de cada registro
            RF[d+1] = instruct_temp[15:8];
            RF[d+2] = instruct_temp[23:16];
            RF[d+3] = instruct_temp[31:24]; 
            d +=  32'd4; // Incrementar el índice de los registros directamente
            instruct_temp = file[i]; // Leer la siguiente instrucción del archivo

            if (full_RF_temp == 32'hFFFFFFFF) begin
                i = 32'd33; // Terminar el bucle si se encuentra la última instrucción
            end 
        
        end
        
    /*
        for (integer i = 0; i < 32; i = i + 1) begin
            $display("RF[%0d]: %h", i, RF[i]);
            if ((i+1)%4 == 0) begin
                $display("\n"); // Salto de línea cada 4 registros
            end
        end
*/
        $display("Memory initialized:");
    
    end

    assign instruct={RF[addr+3], RF[addr+2], RF[addr+1], RF[addr]};
    
    always @(instruct) begin
        $display("addr: %d, Instruccion: %h", addr, instruct);
    end
   
    always @(addr) begin
        // Activar la bandera si se accede a la última posición de la memoria
        if (instruct == 32'hFFFFFFFF) begin
            last_instr_flag = 1;
        end
    end


endmodule