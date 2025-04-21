`timescale 1ns / 1ps

module tb_risc_v();

    reg clk, reset;
    wire [31:0] pc_in, pc_out, element1, element2, element3, element4, element5, element6, element7, instruction;

    pipeline_processor rv(clk, reset, pc_in, pc_out, instruction, element1, element2, element3, element4, element5, element6, element7);
    
    initial begin
        reset = 1;
        clk = 0;
        #0.005 reset = 0;
    end
    always #0.001 clk = ~clk;
    
endmodule
