module PC (clk,reset, pc_reg, finish_flag, branch, branch_offset);
input clk, reset, branch;
// Registro para el contador de programa
output reg signed [31:0] pc_reg = 0; // Inicializar a -1
input wire finish_flag;
input wire signed [31:0] branch_offset; // Offset para el salto
reg signed [31:0] pc_reg_next = 4; // Registro para el siguiente valor del PC

// Lógica del contador de programa

always @(posedge clk or posedge branch) begin
        if (!reset && !finish_flag) begin
            if (branch) begin
                pc_reg <= pc_reg + branch_offset; // Salto condicional
            end else begin
                pc_reg <= pc_reg + pc_reg_next; // Incremento normal (instrucción siguiente)
            end
        end
    end

always @(posedge reset) begin
    if (reset==1) begin
        pc_reg = 32'h0;
        $display("PC reset: %h", pc_reg);
    end
end
endmodule
