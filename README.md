# Multi Channel DMA Controller Verification

## Project Objective
To verify a 4-channel DMA Controller using a SystemVerilog layered testbench architecture.

## Architecture Diagram
```mermaid
flowchart TD

    CPU["CPU / Host"]

    CPU -->|"Configure DMA"| REG

    subgraph DMA["DMA Controller"]

        REG["Slave Interface<br/>Registers"]

        REG --> CH1
        REG --> CH2
        REG --> CH3
        REG --> CH4

        CH1["Channel 1<br/>Control Logic"]
        CH2["Channel 2<br/>Control Logic"]
        CH3["Channel 3<br/>Control Logic"]
        CH4["Channel 4<br/>Control Logic"]

        CH1 -->|"Request"| ARB
        CH2 -->|"Request"| ARB
        CH3 -->|"Request"| ARB
        CH4 -->|"Request"| ARB

        ARB["Round Robin<br/>Arbiter"]

        ARB -->|"Grant"| MASTER

        MASTER["Master Interface<br/>Read / Write"]

    end

    MASTER -->|"Data Bus"| MEM
    MASTER -->|"DMA Transfer"| PER

    MEM["System Memory"]
    PER["Peripherals<br/>UART / SPI / ADC / GPIO"]

    MASTER -.->|"Transfer Complete Interrupt"| CPU
```


## Verification Components
- Interface
- Transaction
- Generator
- Driver
- Monitor
- Scoreboard
- Environment
- Test

## Features
- Randomized Stimulus
- Mailbox Communication
- Functional Coverage
- Assertions (SVA)
- Fixed Priority Arbitration

## Tools
- SystemVerilog
- VS Code
- GitHub
- NC-Verilog / Xcelium
- Vivado Simulator

## **Author**
K Sanjana Nayaka 
