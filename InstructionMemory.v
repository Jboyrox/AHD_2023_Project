`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 04:04:48 PM
// Design Name: 
// Module Name: InstructionMemory
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

module InstructionMemory(
    input wire clk, 
    wire fetch_enable,
    input wire [31:0] read_address,
    output reg [31:0] fetched_instruction,
    output reg valid_instruction
);

parameter MemSize = 2048;
reg [31:0] InstructionMem [0:(MemSize/4)-1];

initial begin
    $readmemh("test.mem", InstructionMem);
   
end

always @(posedge clk) begin
    if (fetch_enable) begin
        if (read_address[31:12] == 20'b0000_0001_0000_0000_0000) begin
            fetched_instruction <= InstructionMem[read_address[11:0] >> 2]; 
            valid_instruction <= 1'b1;
        end else
            valid_instruction <= 1'b0;
    end else begin
        fetched_instruction <= fetched_instruction;
        valid_instruction <= 1'b0;
    end
end

endmodule
