# RISC-V Unicycle Processor

This project implements a RISC-V Unicycle Processor in Verilog. The processor supports 32-bit instructions and can execute various types of instructions, including R-type, I-type, conditional branch, load word, and store word instructions.

## Project Structure

The project has the following file structure:

```
RISC-V-Unicycle-Processor
├── src
│   ├── main.v
│   ├── program_counter.v
│   ├── instruction_memory.v
│   ├── register_file.v
│   ├── alu.v
│   ├── sign_extender.v
│   ├── data_memory.v
│   └── processor.v
├── test
│   ├── program_counter_test.v
│   ├── instruction_memory_test.v
│   ├── register_file_test.v
│   ├── alu_test.v
│   ├── sign_extender_test.v
│   ├── data_memory_test.v
│   └── processor_test.v
├── Makefile
└── README.md
```

## Module Descriptions

- `src/main.v`: This file is the top-level module of the RISC-V Unicycle Processor. It instantiates all the required modules and connects them together to create the processor.

- `src/program_counter.v`: This file implements the Program Counter (PC) module. It keeps track of the address of the next instruction to be fetched.

- `src/instruction_memory.v`: This file implements the Instruction Memory module. It stores the instructions that the processor will fetch and execute.

- `src/register_file.v`: This file implements the Register File module. It stores the general-purpose registers used by the processor.

- `src/alu.v`: This file implements the Arithmetic Logic Unit (ALU) module. It performs arithmetic and logical operations on data.

- `src/sign_extender.v`: This file implements the Sign Extender module. It extends the sign of immediate values used in instructions.

- `src/data_memory.v`: This file implements the Data Memory module. It stores data that can be loaded or stored by the processor.

- `src/processor.v`: This file implements the Processor module. It connects all the required modules together and controls the execution of instructions.

## Testing

The project includes testbenches for each module to verify their functionality. The testbenches are located in the `test` directory:

- `test/program_counter_test.v`: Testbench for the Program Counter module.

- `test/instruction_memory_test.v`: Testbench for the Instruction Memory module.

- `test/register_file_test.v`: Testbench for the Register File module.

- `test/alu_test.v`: Testbench for the ALU module.

- `test/sign_extender_test.v`: Testbench for the Sign Extender module.

- `test/data_memory_test.v`: Testbench for the Data Memory module.

- `test/processor_test.v`: Testbench for the Processor module.

## Compilation and Simulation

The `Makefile` provided in the project can be used to automate the compilation and simulation process of the Verilog modules. You can use the following commands:

- `make compile`: Compiles all the Verilog modules.

- `make simulate`: Runs the simulation for the Processor module.

## Usage

To use the RISC-V Unicycle Processor, you can instantiate the Processor module in your own Verilog design and connect it to the necessary inputs and outputs. Make sure to provide the appropriate clock and reset signals.

For detailed information on the usage and implementation of each module, please refer to the source code and comments within the respective files.

## License

This project is licensed under the [MIT License](LICENSE). Feel free to use and modify the code for your own purposes.