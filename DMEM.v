`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 01:50:36 PM
// Design Name: 
// Module Name: DMEM
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


module DMEM(
input wire clk, memread, memwrite,
input wire [3:0] byte_enable,
input wire [31:0] addr, wr_data,
//input[1:0] data_type,
input wire [15:0] switch,
output reg[31:0] out_data
    );

parameter DMEMsize = 4096;
wire[31:0] addr_wa;//word addressed 
//reg[31:0] DMEM[0:(DMEMsize/4)+3];
reg[7:0] DMEM0[0:(DMEMsize/4)-1];
reg[7:0] DMEM1[0:(DMEMsize/4)-1];
reg[7:0] DMEM2[0:(DMEMsize/4)-1];
reg[7:0] DMEM3[0:(DMEMsize/4)-1];
//reg[31:0] SMEM[0:5];// special mem for N number, switches and LED
reg[31:0] N1 = 32'h17192051;
reg[31:0] N2 = 32'h16726992;
reg[15:0] LED;
//reg[31:0] DMEM [0:(DMEMsize/4)]; 

assign addr_wa = (addr[31:0] >> 2); //+ 32'h20000000; //this ram is word addressed, so all the addresses from alu and pc will need to be divided by 4
    
always@(*) begin
    if(memread) begin
        if(addr[31:0] == 32'h00100000)
            out_data <= N1;
        else if(addr[31:0] == 32'h00100004)
            out_data <= N2;
        else if(addr[31:0] == 32'h00100010)
            out_data <= {16'b0,switch};
        else if(addr[31:0] == 32'h00100014) 
            out_data <= {16'b0,LED};
        else 
            out_data <= {DMEM0[addr_wa[9:0]], DMEM1[addr_wa[9:0]], DMEM2[addr_wa[9:0]], DMEM3[addr_wa[9:0]]};  
    end
    else
        out_data <= {16'b0,LED};
        //out_data <= 0;
end




    
always@(posedge clk) begin
    if(memwrite) begin
        if(addr_wa[31:16] == 16'h2000) begin
            if(byte_enable[0])
                DMEM0[addr_wa[9:0]] <= wr_data[07:00];
            if(byte_enable[1])
                DMEM1[addr_wa[9:0]] <= wr_data[15:08];
            if(byte_enable[2])
                DMEM2[addr_wa[9:0]] <= wr_data[23:16];
            if(byte_enable[3])
                DMEM3[addr_wa[9:0]] <= wr_data[31:24];     
        end
        else if(addr[31:0] == 32'h00100014)
            LED <= {16'b0,wr_data[15:0]};
        //else 
                
    end 
         
end   

endmodule