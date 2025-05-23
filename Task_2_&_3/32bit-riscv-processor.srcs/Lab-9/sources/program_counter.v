`timescale 1ns / 1ps

module program_counter(
input [31:0] pc_in,
input clk,
input reset,
input pc_write,
output reg [31:0] pc_out
);
reg pc_s;
always @(posedge clk or posedge reset) begin
    if (~reset) begin
        if (pc_in > 143) begin
            pc_out <= 0;
        end else begin
            if (~pc_s) begin
                pc_out <= 0;
                pc_s <= 1;
            end else if(pc_write) 
            pc_out <= pc_in;
        end
    end else begin
        pc_s <= 0;
        pc_out <= 0;
    end
end
endmodule
