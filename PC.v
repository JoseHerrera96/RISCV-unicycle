module PC (clk,reset, pc_reg,pcnext);
input clk, reset,pcnext;
// Registro para el contador de programa
output reg [31:0] pc_reg;

// Lógica del contador de programa

always begin @(posedge clk or posedge reset)

    if (reset==1)begin
        pc_reg = 32'h0;
        $display("PC cambio: %d", pc_reg);
    end
    
    if (pcnext==1) begin 
        pc_reg = pc_reg + 32'h1;
        $display("PC cambio: %d", pc_reg);
    end
    else begin
        pc_reg = pc_reg;
    end


end

endmodule
