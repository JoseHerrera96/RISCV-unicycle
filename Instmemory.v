module instmemory(addr,instruct, last_instr_flag);
    input [31:0] addr;
    output [31:0] instruct;
    reg [31:0] RF [0:31]; // 32 registros de 32 bits
    output reg last_instr_flag=0; // Bandera para indicar la última instrucción
   
   initial begin
    for (integer i = 0; i < 32; i = i + 1) begin
        RF[i] = 32'hFFFFFFFF; // Inicializar registros a -1
    end
    $readmemh("Test_typeR_typeI.hex", RF);
    $display("Memory initialized:");
    for (integer i = 0; i < 32; i = i + 1) begin
        $display("RF[%0d] = %h", i, RF[i]);
    end
    end
    


    assign instruct=RF[addr]; // Asignar la instrucción correspondiente a la dirección de memoria

    always @(instruct) begin
        // Activar la bandera si se accede a la última posición de la memoria
        if (instruct == 32'hFFFFFFFF) begin
            last_instr_flag = 1;
        end
    end
endmodule