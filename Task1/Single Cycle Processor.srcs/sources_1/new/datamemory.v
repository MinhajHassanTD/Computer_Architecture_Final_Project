`timescale 1ns / 1ps
module data_Memory(
    input [31:0] mem_addr,
    input[31:0] write_data,
    input clk,
    input mem_write,
    input mem_read,
    output [31:0] read_data,
    output  [31:0] element1,
    output  [31:0] element2,
    output  [31:0] element3,
    output  [31:0] element4,
    output  [31:0] element5,
    output  [31:0] element6,
    output  [31:0] element7
);
    reg [7:0] memory [511:0];
    integer i;
    initial begin 
    for (i =0; i < 512; i=i+1) begin
        memory[i] = 32'b0;
        end
    end
    
    assign element1 = memory[256];
    assign element2 = memory[260];
    assign element3 = memory[264];
    assign element4 = memory[268];
    assign element5 = memory[272];
    assign element6 = memory[276];
    assign element7 = memory[280];
    
    assign read_data[7:0] = mem_read? memory[mem_addr]: 8'b0;
    assign read_data[15:8] = mem_read? memory[mem_addr+1]: 8'b0;
    assign read_data[23:16] = mem_read? memory[mem_addr+2]: 8'b0;
    assign read_data[31:24] = mem_read? memory[mem_addr+3]: 8'b0;
    
    
    always @(posedge clk) begin
        if (mem_write) begin
            memory[mem_addr] = write_data[7:0];
            memory[mem_addr+1] = write_data[15:8];
            memory[mem_addr+2] = write_data[23:16];
            memory[mem_addr+3] = write_data[31:24];
          
        end
    end
endmodule
