`timescale 1ns / 1ps
module branch_Unit(
    input [2:0] funct3,
    input [31:0] result,
    input zero,
    input branch,
    output pc_sel
    );
    wire sel;
    assign sel =
        (funct3 == 3'b000 & zero) |
        (funct3 == 3'b100 & result[31]) | 
        (funct3 == 3'b101 & (~result[31] | zero)); 
    assign pc_sel = branch & sel;
    
endmodule
