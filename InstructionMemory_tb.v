`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 08:57:06 PM
// Design Name: 
// Module Name: IMEM_testbench
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


module InstructionMemory();
reg clk, fetch_enable;
reg[31:0] read_address;
wire fetched_instruction;
wire[31:0] valid_instruction;


InstructionMemory dut(
.clk(clk),
.fetch_enable(fetch_enable),
.read_address(read_address),
.fetched_instruction(fetched_instruction),
.valid_instruction(valid_instruction)
);


initial begin
clk = 0;
fetch_enable = 1;
read_address = 32'h0;
end


always #5 clk = ~clk;


initial begin
#10 read_address = 32'h01000000;
#10 read_address = 32'h010007fc;
#10 fetch_enable = 0;
#10 read_address = 32'h01000000;
#10 fetch_enable = 1;

end

endmodule