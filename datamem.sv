module DataMemory (
    input wire clk,
    input wire [31:0] address,
    input wire signed [31:0] write_data,
    input wire write_enable,
    input wire read_enable,
    output reg [31:0] read_data
);

// Memoria de datos
reg [31:0] memory [0:255]; // Memoria de 256 palabras de 32 bits
initial begin
        $readmemh("ProyectoCorto_data.hex", memory); // Cargar instrucciones desde un archivo hexadecimal
    end
// Lógica de escritura y lectura de memoria
always @(posedge clk)
begin
    if (write_enable)
        memory[address] <= write_data;
    if (read_enable)
        read_data <= memory[address];
end

endmodule