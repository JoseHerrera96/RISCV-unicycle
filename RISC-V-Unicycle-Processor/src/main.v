module main;

  // Include module definitions
  `include "program_counter.v"
  `include "instruction_memory.v"
  `include "register_file.v"
  `include "alu.v"
  `include "sign_extender.v"
  `include "data_memory.v"
  `include "processor.v"

  // Instantiate modules
  program_counter pc();
  instruction_memory im();
  register_file rf();
  alu alu();
  sign_extender extender();
  data_memory dm();
  processor proc(
    .pc(pc),
    .im(im),
    .rf(rf),
    .alu(alu),
    .extender(extender),
    .dm(dm)
  );

endmodule