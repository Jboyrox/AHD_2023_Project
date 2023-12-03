
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 12:05:45 AM
// Design Name: 
// Module Name: DECODER_testbench
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


module DECODER_testbench();

reg[31:0] inst;
wire[4:0] aluOperation;
wire[2:0] immediateSelect;
wire stop;


DECODER dut(

.inst(inst),
.aluOperation(aluOperation),
.immediateSelect(immediateSelect),
.stop(stop)
);
/*
initial begin
clk = 0;
end

always #5 clk = ~clk;
*/
initial begin
inst = 32'b01000000001000001000000110110011;// this is sub r3 r2 r1 
#10 inst = 32'b00000100000000000000000011101111;// this is JAL r1 64
#10 inst = 32'b00000100001000001100000001100011;// this is BLT R2 R1 64
end

endmodule
