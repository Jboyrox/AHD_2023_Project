`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2022 10:36:31 PM
// Design Name: 
// Module Name: PC_testbench
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


module program_counter_TB();
reg clk, 
write_enable,
 reset;
reg [31:0] new_address; 
wire[31:0] current_address;
wire address_updated;

program_counter dut(
.clk(clk),
.write_enable(write_enable),
.reset(reset),
.new_address(new_address),
.current_address(current_address),
.address_updated(address_updated)

);
reg i;
initial begin

clk <= 0;
reset <= 1;
write_enable <= 0;
#5; 
clk<=1;
new_address <= 32'h00000000;
#5;
$display(current_address);
if(current_address==32'h01000000)
begin
$display("blah");
i=1;
end
else
begin
i=0;
end;
#5;
 clk<=0;
reset <= 0;
write_enable <= 1;
new_address <= 32'hffffffff;
#5;
 clk<=1;
$display(current_address);
$display(i);
#5;
if(current_address==32'hffffffff)
begin
if(i==1)
begin
i=1;
end
else
begin
i=0;
end
end
else 
begin
i=0;
end
if(i==1)
begin
$display ("all tests passed the program counter is functional ");
end
else
$display ("program counter is not working");
begin
end
end






endmodule