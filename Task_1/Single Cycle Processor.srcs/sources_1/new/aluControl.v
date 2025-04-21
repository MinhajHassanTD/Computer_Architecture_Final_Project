`timescale 1ns / 1ps

module alu_Control(
input [1:0] aluop,
input [3:0] funct,
output [3:0] operation
    );
    
    assign operation =
        aluop == 2'b00 ? 4'b0010: 
        aluop == 2'b01 ? 4'b0110:
        aluop == 2'b10 ? (
        funct[2:0] == 3'b000 ? 4'b0010: 
        funct == 4'b1000 ? 4'b0110: 
        funct[2:0] == 3'b111 ? 4'b0000: 
        funct[2:0] == 3'b110 ? 4'b0001: 
        funct[2:0] == 3'b001 ? 4'b1000: 
        4'bx
        ):
        4'bx;
endmodule
