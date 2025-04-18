module instmemory(addr,WriteReg,WriteData,RegWrite,instruct,clock);
    input [31:0] addr,WriteReg;
    input [31:0] WriteData;
    input RegWrite, clock;
    output [31:0] instruct;
    reg [31:0] RF [0:31]; // 32 registros de 32 bits
   
   initial begin
    for (integer i = 0; i < 32; i = i + 1) begin
        RF[i] = 32'h0; // Inicializar registros a 0
    end
    $readmemh("RISCV (add,sub,or).hex", RF);
    $display("Memory initialized:");
    for (integer i = 0; i < 32; i = i + 1) begin
        $display("RF[%0d] = %h", i, RF[i]);
    end
    end
    
    always @(posedge clock) begin 
        if (RegWrite==1) 
            RF[WriteReg]<=WriteData;
    end

    assign instruct=RF[addr]; // Asignar la instrucción correspondiente a la dirección de memoria
endmodule