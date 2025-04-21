`timescale 1ns / 1ps

module tb_MainProcessor();

    reg clk, reset;
    wire [31:0] element1, element2, element3, element4, element5, element6, element7;
    main_processor mp (clk, reset, element1, element2, element3, element4, element5, element6, element7);
    
    initial begin
        reset = 1;
        clk = 0;
        #5 reset = 0;
    end
    always # 1 clk = ~clk;
    
endmodule
