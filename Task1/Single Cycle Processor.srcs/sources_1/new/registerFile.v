`timescale 1ns / 1ps
module register_File(
    input [31:0] data_in,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] dest,
    input write_enable,
    input clk,
    input rst,
    output reg [31:0] data_out1,
    output reg [31:0] data_out2
);

    reg [31:0] reg_array [31:0]; // Register array to store values

    integer i;
    initial begin
        reg_array[0] = 0;
        for (i = 1; i < 32; i = i + 1)
            reg_array[i] = i + 32'b1;
    end

    always @(posedge clk) begin
        if (write_enable)
            reg_array[dest] <= data_in; // Write data to destination register
    end

    always @(*) begin
        reg_array[0] <= 0; // Ensure register 0 is always 0
        if (~rst) begin
            data_out1 <= reg_array[read_reg1];
            data_out2 <= reg_array[read_reg2];
        end else begin
            data_out1 <= 32'b0;
            data_out2 <= 32'b0;
        end
    end

endmodule