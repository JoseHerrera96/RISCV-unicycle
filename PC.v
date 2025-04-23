module PC (clk,reset, pc_reg, finish_flag);
input clk, reset;
// Registro para el contador de programa
output reg [31:0] pc_reg;
input wire finish_flag;

// Lógica del contador de programa
always @(posedge clk) begin
    if (!reset && !finish_flag) begin
        pc_reg <= pc_reg + 32'h1;
    end
end

always @(posedge reset) begin
    if (reset==1) begin
        pc_reg = 32'hFFFFFFFF;
        $display("PC reset: %h", pc_reg);
    end
end
endmodule
