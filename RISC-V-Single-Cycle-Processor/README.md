# RISC-V Single Cycle Processor

This project implements a Single Cycle Processor of 32 data bits following the RISC-V architecture. It consists of several Verilog modules that are wired together to simulate the processor's behavior.

## Project Structure

The project has the following file structure:

```
RISC-V-Single-Cycle-Processor
├── src
│   ├── main.v
│   └── modules
│       ├── ALU.v
│       ├── ControlUnit.v
│       ├── DataMemory.v
│       ├── InstructionMemory.v
│       ├── RegisterFile.v
│       └── PC.v
├── testbenches
│   ├── ALU_tb.v
│   ├── ControlUnit_tb.v
│   ├── DataMemory_tb.v
│   ├── InstructionMemory_tb.v
│   ├── RegisterFile_tb.v
│   └── PC_tb.v
├── Makefile
└── README.md
```

## File Descriptions

- `src/main.v`: This file is the main module that wires all the selected modules together to simulate the behavior of the Single Cycle Processor.

- `src/modules/ALU.v`: This file contains the implementation of the Arithmetic Logic Unit (ALU) module.

- `src/modules/ControlUnit.v`: This file contains the implementation of the Control Unit module.

- `src/modules/DataMemory.v`: This file contains the implementation of the Data Memory module.

- `src/modules/InstructionMemory.v`: This file contains the implementation of the Instruction Memory module.

- `src/modules/RegisterFile.v`: This file contains the implementation of the Register File module.

- `src/modules/PC.v`: This file contains the implementation of the Program Counter (PC) module.

- `testbenches/ALU_tb.v`: This file contains the testbench for the ALU module.

- `testbenches/ControlUnit_tb.v`: This file contains the testbench for the Control Unit module.

- `testbenches/DataMemory_tb.v`: This file contains the testbench for the Data Memory module.

- `testbenches/InstructionMemory_tb.v`: This file contains the testbench for the Instruction Memory module.

- `testbenches/RegisterFile_tb.v`: This file contains the testbench for the Register File module.

- `testbenches/PC_tb.v`: This file contains the testbench for the Program Counter module.

- `Makefile`: This file is used to automate the compilation and simulation process of the Verilog modules and testbenches.

## Usage

To compile and simulate the Single Cycle Processor, follow these steps:

1. Open a terminal and navigate to the project directory.

2. Run the following command to compile the Verilog modules and testbenches:

   ```
   make compile
   ```

3. Run the following command to simulate the Single Cycle Processor:

   ```
   make simulate
   ```

## Contributing

Contributions to this project are welcome. Feel free to open issues and submit pull requests.

## License

This project is licensed under the [MIT License](LICENSE).