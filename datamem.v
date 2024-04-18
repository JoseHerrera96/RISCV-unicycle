module DataMemory (
    input wire clk,
    input wire [31:0] address,
    input wire [31:0] write_data,
    input wire write_enable,
    input wire read_enable,
    output reg [31:0] read_data
);

// Memoria de datos
reg [31:0] memory [0:255]; // Memoria de 256 palabras de 32 bits

// Lógica de escritura y lectura de memoria
always @(posedge clk)
begin
    if (write_enable)
        memory[address[9:2]] <= write_data;
    if (read_enable)
        read_data <= memory[address[9:2]];
end

endmodule