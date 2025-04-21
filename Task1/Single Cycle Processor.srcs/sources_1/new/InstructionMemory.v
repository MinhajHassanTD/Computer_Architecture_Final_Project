`timescale 1ns / 1ps
module instruction_Memory(
    input [31:0] instruction_address,
    output[31:0] instruction
);
    reg [7:0] instruction_memory [143:0];

initial begin
{instruction_memory[3], instruction_memory[2], instruction_memory[1], instruction_memory[0]}     = 32'h00100293;
{instruction_memory[7], instruction_memory[6], instruction_memory[5], instruction_memory[4]}     = 32'h10502023;
{instruction_memory[11], instruction_memory[10], instruction_memory[9], instruction_memory[8]}   = 32'h00200293;
{instruction_memory[15], instruction_memory[14], instruction_memory[13], instruction_memory[12]} = 32'h10502223;
{instruction_memory[19], instruction_memory[18], instruction_memory[17], instruction_memory[16]} = 32'h00300293;
{instruction_memory[23], instruction_memory[22], instruction_memory[21], instruction_memory[20]} = 32'h10502423;
{instruction_memory[27], instruction_memory[26], instruction_memory[25], instruction_memory[24]} = 32'h00400293;
{instruction_memory[31], instruction_memory[30], instruction_memory[29], instruction_memory[28]} = 32'h10502623;
{instruction_memory[35], instruction_memory[34], instruction_memory[33], instruction_memory[32]} = 32'h00500293;
{instruction_memory[39], instruction_memory[38], instruction_memory[37], instruction_memory[36]} = 32'h10502823;
{instruction_memory[43], instruction_memory[42], instruction_memory[41], instruction_memory[40]} = 32'h00600293;
{instruction_memory[47], instruction_memory[46], instruction_memory[45], instruction_memory[44]} = 32'h10502a23;
{instruction_memory[51], instruction_memory[50], instruction_memory[49], instruction_memory[48]} = 32'h00700293;
{instruction_memory[55], instruction_memory[54], instruction_memory[53], instruction_memory[52]} = 32'h10502c23;
{instruction_memory[59], instruction_memory[58], instruction_memory[57], instruction_memory[56]} = 32'h10000513;
{instruction_memory[63], instruction_memory[62], instruction_memory[61], instruction_memory[60]} = 32'h00700593;
{instruction_memory[67], instruction_memory[66], instruction_memory[65], instruction_memory[64]} = 32'h00000413;
{instruction_memory[71], instruction_memory[70], instruction_memory[69], instruction_memory[68]} = 32'h04b40663;
{instruction_memory[75], instruction_memory[74], instruction_memory[73], instruction_memory[72]} = 32'h008004b3;
{instruction_memory[79], instruction_memory[78], instruction_memory[77], instruction_memory[76]} = 32'h02b48e63;
{instruction_memory[83], instruction_memory[82], instruction_memory[81], instruction_memory[80]} = 32'h00241313;
{instruction_memory[87], instruction_memory[86], instruction_memory[85], instruction_memory[84]} = 32'h00249393;
{instruction_memory[91], instruction_memory[90], instruction_memory[89], instruction_memory[88]} = 32'h00a30333;
{instruction_memory[95], instruction_memory[94], instruction_memory[93], instruction_memory[92]} = 32'h00a383b3;
{instruction_memory[99], instruction_memory[98], instruction_memory[97], instruction_memory[96]} = 32'h00032e03;
{instruction_memory[103], instruction_memory[102], instruction_memory[101], instruction_memory[100]} = 32'h0003ae83;
{instruction_memory[107], instruction_memory[106], instruction_memory[105], instruction_memory[104]} = 32'h01de5c63;
{instruction_memory[111], instruction_memory[110], instruction_memory[109], instruction_memory[108]} = 32'h000e0f13;
{instruction_memory[115], instruction_memory[114], instruction_memory[113], instruction_memory[112]} = 32'h000e8e13;
{instruction_memory[119], instruction_memory[118], instruction_memory[117], instruction_memory[116]} = 32'h000f0e93;
{instruction_memory[123], instruction_memory[122], instruction_memory[121], instruction_memory[120]} = 32'h01c32023;
{instruction_memory[127], instruction_memory[126], instruction_memory[125], instruction_memory[124]} = 32'h01d3a023;
{instruction_memory[131], instruction_memory[130], instruction_memory[129], instruction_memory[128]} = 32'h00148493;
{instruction_memory[135], instruction_memory[134], instruction_memory[133], instruction_memory[132]} = 32'hfc0004e3;
{instruction_memory[139], instruction_memory[138], instruction_memory[137], instruction_memory[136]} = 32'h00140413;
{instruction_memory[143], instruction_memory[142], instruction_memory[141], instruction_memory[140]} = 32'hfa000ce3;
end

    assign instruction[7:0] = instruction_memory[instruction_address];
    assign instruction[15:8] = instruction_memory[instruction_address + 1];
    assign instruction[23:16] = instruction_memory[instruction_address + 2];
    assign instruction[31:24] = instruction_memory[instruction_address + 3];
endmodule
