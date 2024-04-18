module PC (clk,reset,pc_out);
input wire clk,
input wire reset,
output reg [31:0] pc_out
// Registro para el contador de programa
reg [31:0] pc_reg;

// Lógica del contador de programa
always @(posedge clk, posedge reset)
begin
    if (reset)
        pc_reg <= 32'h0;
    else
        pc_reg <= pc_reg + 4;
end

assign pc_out = pc_reg;

endmodule
