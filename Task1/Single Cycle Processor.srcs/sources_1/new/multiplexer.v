`timescale 1ns / 1ps

module multiplexer(
    input [31:0] input_a,
    input [31:0] input_b,
    input select,
    output [31:0] mux_out
);

    assign mux_out = select == 0 ? input_a : input_b;

endmodule