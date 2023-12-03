`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 01:50:36 PM
// Design Name: 
// Module Name: DataMemory
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

module DataMemory(
    input wire clk, read_enable, write_enable,
    input wire [3:0] byte_sel,
    input wire [31:0] memory_addr, write_data,
    input wire  [15:0] user_switch,
    output reg [31:0] read_data
);

parameter DataMemSize = 4096;
wire [31:0] word_addr; // Word addressed
reg [7:0] DataMem0[0:(DataMemSize/4)-1];
reg [7:0] DataMem1[0:(DataMemSize/4)-1];
reg [7:0] DataMem2[0:(DataMemSize/4)-1];
reg [7:0] DataMem3[0:(DataMemSize/4)-1];
reg [31:0] SpecialNum1 = 32'h17192051;
reg [31:0] SpecialNum2 = 32'h16726992;
reg [31:0] SpecialNum3 = 32'h16726992;
reg [15:0] LEDs;

assign word_addr = memory_addr >> 2; // Converting to word address

always @(*) begin
    if (read_enable) begin
        case (memory_addr)
            32'h00100000: read_data <= SpecialNum1;
            32'h00100004: read_data <= SpecialNum2;
            32'h00100008: read_data <= SpecialNum3;
            32'h00100010: read_data <= {16'b0, user_switch};
            32'h00100014: read_data <= {16'b0, LEDs};
            default: read_data <= {DataMem0[word_addr[9:0]], DataMem1[word_addr[9:0]], DataMem2[word_addr[9:0]], DataMem3[word_addr[9:0]]};
        endcase
    end else begin
        read_data <= {16'b0, LEDs};
    end
end

always @(posedge clk) begin
    if (write_enable) begin
        if (word_addr[31:16] == 16'h2000) begin
            if (byte_sel[0]) DataMem0[word_addr[9:0]] <= write_data[07:00];
            if (byte_sel[1]) DataMem1[word_addr[9:0]] <= write_data[15:08];
            if (byte_sel[2]) DataMem2[word_addr[9:0]] <= write_data[23:16];
            if (byte_sel[3]) DataMem3[word_addr[9:0]] <= write_data[31:24];
        end else if (memory_addr == 32'h00100014) begin
            LEDs <= write_data[15:0];
        end
    end
    $display(DataMem3);
    $display(DataMem2);
    $display(DataMem1);
    $display(DataMem0);
end

endmodule
