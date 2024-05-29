`include "program_counter.v"
`include "instruction_memory.v"
`include "register_file.v"
`include "alu.v"
`include "sign_extender.v"
`include "data_memory.v"

module processor (
  // Inputs
  input wire clk,
  input wire reset,
  // Outputs
  output wire [31:0] result
);

  // Instantiate modules
  /*
 input wire clk,
  input wire reset,
  input wire enable,
  input wire [31:0] branch_address,
  output wire [31:0] pc_out
  */
  program_counter PC (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .branch_address(branch_address),
    .pc_out(pc_out)
    // Add module connections here
  );

  instruction_memory IM (
    .clk(clk),
    .reset(reset),
    .address(pc_out),
    .instruction_out(instruction)
    // Add module connections here
  );

  register_file RF (
    .clk(clk),
    .reset(reset),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_data),
    .reg_write(reg_write),
    .read_data1(read_data1),
    .read_data2(read_data2)
    // Add module connections here
  );

  alu ALU (
    .clk(clk),
    .reset(reset),
    .operand1(operand1),
    .operand2(operand2),
    .aluOp(aluOp),
    .result(result),
    .zero(zero)
    // Add module connections here
  );

  sign_extender SE (
    .clk(clk),
    .reset(reset),
    // Add module connections here
  );

  data_memory DM (
    .clk(clk),
    .reset(reset),
    // Add module connections here
  );

  // Add control logic and connections here

  // Add data path connections here

  // Assign result

endmodule