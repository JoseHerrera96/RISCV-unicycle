module PC (clk,reset, pc_reg);
input clk, reset;
// Registro para el contador de programa
output reg [31:0] pc_reg;

// Lógica del contador de programa

always begin @(posedge clk or posedge reset)

    if (reset==1)
        pc_reg <= 32'h0;
    
    else
        pc_reg <= pc_reg + 32'h1;
        $display("PC cambio: %d", pc_reg);


end

endmodule
