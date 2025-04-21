`timescale 1ns / 1ps

module main_processor(
    input clk,
    input reset,
    output wire [31:0] element1,
    output wire [31:0] element2,
    output wire [31:0] element3,
    output wire [31:0] element4,
    output wire [31:0] element5,
    output wire [31:0] element6,
    output wire [31:0] element7
);

        wire [31:0] pcIn;
        wire [31:0] pcOut;
        wire [31:0] instruction;
        wire [6:0] opcode;
        wire [4:0] rd;
        wire [2:0] func3;
        wire [4:0] rs1;
        wire [4:0] rs2;
        wire [6:0] func7;
        wire branch;
        wire memRead;
        wire memToReg;
        wire [1:0] aluOp;
        wire memWrite;
        wire aluSrc;
        wire regWrite;
        wire [31:0] imm;
        wire [31:0] rs1Data;
        wire [31:0] rs2Data;
        wire [31:0] nextInsAddress;
        wire [31:0] branchInsAddress;
        wire [3:0] operation;
        wire [31:0] aluSecondOperand;
        wire zero;
        wire [31:0] aluResult;
        wire pcMuxSel;
        wire [31:0] readData;
        wire [31:0] writeData;


        program_Counter pc1 (pcIn, clk, reset, pcOut);
        instruction_Memory im1 (pcOut, instruction);
        instruction_Parser ip1 (instruction, opcode, rd, func3, rs1, rs2, func7);
        control_Unit cu1 (reset, opcode, branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWrite);
        register_File rf1 (writeData, rs1, rs2, rd, regWrite, clk, reset, rs1Data, rs2Data);
        data_Extractor de1 (instruction, imm);
        adder64 add1 (pcOut, 4, nextInsAddress);
        adder64 add2 (pcOut, imm << 1 , branchInsAddress);
        alu_Control ac1 (aluOp, {instruction[30], instruction[14:12]}, operation);
        multiplexer regMux1 (rs2Data, imm, aluSrc, aluSecondOperand);
        alu64bit alu1 (rs1Data, aluSecondOperand, operation, zero, aluResult);
        branch_Unit bu1 (func3, aluResult, zero, branch, pcMuxSel);
        multiplexer pcMux1 (nextInsAddress, branchInsAddress, pcMuxSel, pcIn);
        data_Memory dm1 (aluResult, rs2Data, clk, memWrite, memRead, readData, element1, element2, element3, element4, element5, element6, element7);
        multiplexer memMux1 (aluResult, readData, memToReg, writeData);


endmodule
