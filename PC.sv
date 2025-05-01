module PC (clk,reset, pc_reg, finish_flag, branch, branch_offset);
input clk, reset, branch;
// Registro para el contador de programa
output reg signed [31:0] pc_reg = 32'hFFFFFFFC;; // Inicializar a -4
input wire finish_flag;
input wire signed [31:0] branch_offset; // Offset para el salto
reg signed [31:0] pc_reg_next = 32'sd4; // Registro para el siguiente valor del PC

// Lógica del contador de programa

always @(posedge clk) begin
    if (!reset && !finish_flag && !branch) begin
        pc_reg <= pc_reg + pc_reg_next; // Incremento normal (instrucción siguiente)
    end
end

always @(posedge branch) begin
    if (!reset && !finish_flag) begin
        pc_reg <= pc_reg + branch_offset; // Salto condicional
    end
end

always @(posedge reset) begin
    if (reset==1) begin
        pc_reg = 32'hFFFFFFFC; // Inicializar el PC a -4
        $display("PC reset: %h", pc_reg);
    end
end
endmodule
