`timescale 1ns / 1ps

module program_Counter(
    input [31:0] pc_input,
    input clk,
    input rst,
    output reg [31:0] pc_output
);

    reg pc_flag;

    always @(posedge clk or posedge rst) begin
        if (~rst) begin
            if (pc_input > 143) begin
                pc_output <= 0;
            end else begin
                if (~pc_flag) begin
                    pc_output <= 0;
                    pc_flag <= 1;
                end else 
                    pc_output <= pc_input;
            end
        end else begin
            pc_flag <= 0;
            pc_output <= 0;
        end
    end
endmodule