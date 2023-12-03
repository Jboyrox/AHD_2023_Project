`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2022 01:17:15 PM
// Design Name: 
// Module Name: DataMemoryTestbench
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

module DataMemoryTestbench();
    reg clk, read_enable, write_enable;
    reg [3:0] byte_sel;
    reg [31:0] memory_addr, write_data;
    wire [31:0] read_data;
//    reg [2:0] data_type;

    DataMemory dut(
        .clk(clk),
        .read_enable(read_enable),
        .write_enable(write_enable),
        .byte_sel(byte_sel),
        .memory_addr(memory_addr),
        .write_data(write_data),
        .read_data(read_data)
    );
   reg i;
    initial begin
        clk = 0;
        memory_addr = 32'h00100000; // Address for first team number
        memory_addr = 32'h00100004; // Address for second team number
        memory_addr = 32'h00100008; // Address for third special number
        read_enable = 1;
//        write_data = 32'h12345678; // Data for writing
//        data_type = 1; // Half word
    end

    always #5 clk = ~clk;

//    initial begin
//        #5 write_enable = 1; // Enable write
//       #10 memory_addr = 32'h0000000c; // Address out of range
//        #10 memory_addr = 32'h8000000c; // Valid address to write to
//        #10;
//       memory_addr = 32'h80000010; // Next valid address
//    end

endmodule
