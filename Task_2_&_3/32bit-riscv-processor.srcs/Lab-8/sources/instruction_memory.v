`timescale 1ns / 1ps
module instruction_memory(
    input clk,
    input reset,
    input [31:0] instruction_address,
    output reg[31:0] instruction
);
    reg [7:0] ins_mem [143:0];

initial begin

{ins_mem[3], ins_mem[2], ins_mem[1], ins_mem[0]}     = 32'h00100293;
{ins_mem[7], ins_mem[6], ins_mem[5], ins_mem[4]}     = 32'h10502023;
{ins_mem[11], ins_mem[10], ins_mem[9], ins_mem[8]}   = 32'h00200293;
{ins_mem[15], ins_mem[14], ins_mem[13], ins_mem[12]} = 32'h10502223;
{ins_mem[19], ins_mem[18], ins_mem[17], ins_mem[16]} = 32'h00300293;
{ins_mem[23], ins_mem[22], ins_mem[21], ins_mem[20]} = 32'h10502423;
{ins_mem[27], ins_mem[26], ins_mem[25], ins_mem[24]} = 32'h00400293;
{ins_mem[31], ins_mem[30], ins_mem[29], ins_mem[28]} = 32'h10502623;
{ins_mem[35], ins_mem[34], ins_mem[33], ins_mem[32]} = 32'h00500293;
{ins_mem[39], ins_mem[38], ins_mem[37], ins_mem[36]} = 32'h10502823;
{ins_mem[43], ins_mem[42], ins_mem[41], ins_mem[40]} = 32'h00600293;
{ins_mem[47], ins_mem[46], ins_mem[45], ins_mem[44]} = 32'h10502a23;
{ins_mem[51], ins_mem[50], ins_mem[49], ins_mem[48]} = 32'h00700293;
{ins_mem[55], ins_mem[54], ins_mem[53], ins_mem[52]} = 32'h10502c23;
{ins_mem[59], ins_mem[58], ins_mem[57], ins_mem[56]} = 32'h10000513;
{ins_mem[63], ins_mem[62], ins_mem[61], ins_mem[60]} = 32'h00700593;
{ins_mem[67], ins_mem[66], ins_mem[65], ins_mem[64]} = 32'h00000413;
{ins_mem[71], ins_mem[70], ins_mem[69], ins_mem[68]} = 32'h04b40663;
{ins_mem[75], ins_mem[74], ins_mem[73], ins_mem[72]} = 32'h008004b3;
{ins_mem[79], ins_mem[78], ins_mem[77], ins_mem[76]} = 32'h02b48e63;
{ins_mem[83], ins_mem[82], ins_mem[81], ins_mem[80]} = 32'h00241313;
{ins_mem[87], ins_mem[86], ins_mem[85], ins_mem[84]} = 32'h00249393;
{ins_mem[91], ins_mem[90], ins_mem[89], ins_mem[88]} = 32'h00a30333;
{ins_mem[95], ins_mem[94], ins_mem[93], ins_mem[92]} = 32'h00a383b3;
{ins_mem[99], ins_mem[98], ins_mem[97], ins_mem[96]} = 32'h00032e03;
{ins_mem[103], ins_mem[102], ins_mem[101], ins_mem[100]} = 32'h0003ae83;
{ins_mem[107], ins_mem[106], ins_mem[105], ins_mem[104]} = 32'h01de5c63;
{ins_mem[111], ins_mem[110], ins_mem[109], ins_mem[108]} = 32'h000e0f13;
{ins_mem[115], ins_mem[114], ins_mem[113], ins_mem[112]} = 32'h000e8e13;
{ins_mem[119], ins_mem[118], ins_mem[117], ins_mem[116]} = 32'h000f0e93;
{ins_mem[123], ins_mem[122], ins_mem[121], ins_mem[120]} = 32'h01c32023;
{ins_mem[127], ins_mem[126], ins_mem[125], ins_mem[124]} = 32'h01d3a023;
{ins_mem[131], ins_mem[130], ins_mem[129], ins_mem[128]} = 32'h00148493;
{ins_mem[135], ins_mem[134], ins_mem[133], ins_mem[132]} = 32'hfc0004e3;
{ins_mem[139], ins_mem[138], ins_mem[137], ins_mem[136]} = 32'h00140413;
{ins_mem[143], ins_mem[142], ins_mem[141], ins_mem[140]} = 32'hfa000ce3;




end
    
always @(*)
    begin
    if (reset)
        instruction <= 0;
    else if (clk)
    begin
        instruction[7:0] <= ins_mem[instruction_address];
        instruction[15:8] <= ins_mem[instruction_address + 1];
        instruction[23:16] <= ins_mem[instruction_address + 2];
        instruction[31:24] <= ins_mem[instruction_address + 3];
        end
    end    

endmodule