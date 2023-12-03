`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 12:32:51 AM
// Design Name: 
// Module Name: DECODER_ALU_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DECODER_ALU_test();

reg[31:0] instruction;
reg clk, rst, regwr; 
reg memread;
wire[31:0] data;
wire[31:0] regwrdata;


DECODER_ALU test(
.instruction(instruction),
.clk(clk),
.rst(rst),
.regwr(regwr),
.data(data),
.memread(memread),
.regwrdata(regwrdata)
);


initial begin
clk = 0;
rst = 1;

end
always #5 clk = ~clk;

initial begin
#5; 
rst = 0;
memread = 1;
#5 instruction = 32'b0000001000_00001_000_00010_0000011;
#5 regwr = 1;

end

endmodule