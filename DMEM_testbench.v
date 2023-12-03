`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2022 01:17:15 PM
// Design Name: 
// Module Name: DMEM_testbench
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


module DMEM_testbench();
reg clk, memread, memwrite;
reg[2:0] data_type;
reg[31:0] addr, wr_data;
wire[31:0] out_data;

DMEM dut(
.clk(clk),
.memread(memread),
.memwrite(memwrite),
.addr(addr),
.wr_data(wr_data),
.out_data(out_data)
);

initial begin
clk = 0;
addr = 32'h00100004;//address for second N number in hex
memread = 1;
wr_data = 32'h12345678;//data for writing in
//data_type = 1;//half word
end

always #5 clk = ~clk;

initial begin
#5 memwrite = 1;// for letting it write
#10 addr = 32'h0000000c;//an address that is out of range will output 0
//#10 addr = 32'h8000000c;//a valid address to write to, specifically DMEM[3]
////datatype half word so it will store 5678 into DMEM[3]
//#10;
//addr = 32'h80000010; //next valid address
//data_type = 3;//datatype is for LBU, it will store the full 32 bits into DMEM[4], but output will only be the last 8 bits and 0 extended



end


endmodule