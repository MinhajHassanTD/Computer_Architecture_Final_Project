`timescale 1ns / 1ps
module pipeline_processor(
    input clk,
    input reset,
    output wire [31:0] pc_in,
    output wire [31:0] pc_out,
    output wire [31:0] instruction,
    output wire [31:0] element1,
    output wire [31:0] element2,
    output wire [31:0] element3,
    output wire [31:0] element4,
    output wire [31:0] element5,
    output wire [31:0] element6,
    output wire [31:0] element7
);

wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] func3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] func7;
wire branch;
wire mem_read;
wire mem_to_reg;
wire [1:0] alu_op;
wire mem_write;
wire alu_src;
wire reg_write;
wire [31:0] imm;
wire [31:0] rs1_data;
wire [31:0] rs2_data;
wire [31:0] next_ins_address;
wire [31:0] branch_ins_address;
wire [3:0] operation;
wire [31:0] alu_second_operand;
wire zero;
wire [31:0] alu_result;
wire [31:0] read_data;
wire [31:0] write_data;
wire pc_mux_sel;
//wires for pipeline registers IF_ID
wire [31:0] pc_out_IF_ID;
wire [31:0] ins_out_IF_ID;
//ID_EX
wire [31:0] pc_out_ID_EX, read_data1_ID_EX, read_data2_ID_EX, imm_ID_EX;
wire [4:0] rd_ID_EX, rs1_ID_EX, rs2_ID_EX;
wire [3:0] funct_ID_EX;
wire branch_ID_EX , mem_read_ID_EX, mem_to_reg_ID_EX, mem_write_ID_EX , alu_src_ID_EX , reg_write_ID_EX;
wire [1:0] alu_op_ID_EX;
//EX_MEM
wire mem_to_reg_EX_MEM, reg_write_EX_MEM, branch_EX_MEM, mem_write_EX_MEM, mem_read_EX_MEM, zero_EX_MEM;
wire [31:0] adder_EX_MEM, alu_result_EX_MEM, mux_rd2_EX_MEM;
wire [4:0] rd_EX_MEM;
wire [3:0] funct_EX_MEM;
//MEM_WB
wire [31:0] read_data_MEM_WB, alu_result_MEM_WB;
wire [4:0] rd_MEM_WB;
wire mem_to_reg_MEM_WB, reg_write_MEM_WB;
//Forwarding selection controls
wire [1:0] forward_a, forward_b;
wire [31:0] three_i_mux_out1, three_i_mux_out2;
wire ID_EX_mux_out,IF_ID_Write,PCWrite;


program_counter pc (pc_in, clk, reset, PCWrite,pc_out);
multiplexer pc_mux (next_ins_address, adder_EX_MEM, pc_mux_sel, pc_in);
adder_64 add_1 (pc_out, 4, next_ins_address);
instruction_memory im (clk, reset, pc_out, instruction);
IF_ID_register if_id (clk, reset, pc_out, instruction,IF_ID_Write ,pc_out_IF_ID, ins_out_IF_ID);

instruction_parser ip (ins_out_IF_ID, opcode, rd, func3, rs1, rs2, func7);
control_unit cu (opcode,reset,ID_EX_mux_out,branch, mem_read, mem_to_reg, alu_op, mem_write, alu_src, reg_write);
data_hazard_unit hz(rd_ID_EX,rs1,rs2,mem_read_ID_EX, ID_EX_mux_out,IF_ID_Write,PCWrite);
register_file rf (write_data, rs1, rs2, rd_MEM_WB, reg_write_MEM_WB, clk, reset, rs1_data, rs2_data);
data_extractor de (ins_out_IF_ID, imm);
ID_EX id_ex (clk, reset, pc_out_IF_ID, rs1_data, rs2_data, imm, rd, rs1, rs2, {ins_out_IF_ID[30], ins_out_IF_ID[14:12]}, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, alu_op, pc_out_ID_EX, rs1_ID_EX, rs2_ID_EX, rd_ID_EX, imm_ID_EX, read_data1_ID_EX, read_data2_ID_EX, funct_ID_EX, branch_ID_EX, mem_read_ID_EX, mem_to_reg_ID_EX, mem_write_ID_EX,reg_write_ID_EX, alu_src_ID_EX, alu_op_ID_EX); 

three_input_mux mx1(read_data1_ID_EX, write_data, alu_result_EX_MEM, forward_a, three_i_mux_out1);
three_input_mux mx2(read_data2_ID_EX, write_data, alu_result_EX_MEM, forward_b, three_i_mux_out2);
ForwardingUnit fwd(rs1_ID_EX, rs2_ID_EX, rd_EX_MEM, rd_MEM_WB, reg_write_MEM_WB, reg_write_EX_MEM, forward_a, forward_b);
multiplexer reg_mux (three_i_mux_out2, imm_ID_EX, alu_src_ID_EX, alu_second_operand);
adder_64 add_2 (pc_out_ID_EX, imm_ID_EX << 1 , branch_ins_address);
alu_control ac (alu_op_ID_EX, funct_ID_EX, operation);
alu_64bit alu (three_i_mux_out1, alu_second_operand, operation, zero, alu_result);
branch_unit bu (funct_ID_EX[2:0], alu_result, zero, branch_ID_EX, pc_mux_sel);
EX_MEM_register ex_mem (clk, reset, mem_to_reg_ID_EX, reg_write_ID_EX, branch_ID_EX, mem_write_ID_EX, mem_read_ID_EX, branch_ins_address, zero, alu_result, three_i_mux_out2, rd_ID_EX, funct_ID_EX,  mem_to_reg_EX_MEM, reg_write_EX_MEM, branch_EX_MEM, mem_write_EX_MEM, mem_read_EX_MEM, adder_EX_MEM, zero_EX_MEM, alu_result_EX_MEM, mux_rd2_EX_MEM, rd_EX_MEM, funct_EX_MEM); 

//branch_unit bu (funct_EX_MEM[2:0], alu_result_EX_MEM, zero_EX_MEM, branch_EX_MEM, pc_mux_sel);
data_memory dm (alu_result_EX_MEM, mux_rd2_EX_MEM, clk, mem_write_EX_MEM, mem_read_EX_MEM, read_data, element1, element2, element3, element4, element5, element6, element7 );
MEM_WB mem_wb (clk,reset, read_data, alu_result_EX_MEM, rd_EX_MEM, mem_to_reg_EX_MEM, reg_write_EX_MEM, read_data_MEM_WB, alu_result_MEM_WB, rd_MEM_WB, mem_to_reg_MEM_WB, reg_write_MEM_WB);
multiplexer mem_mux (alu_result_MEM_WB, read_data_MEM_WB, mem_to_reg_MEM_WB, write_data);


endmodule
