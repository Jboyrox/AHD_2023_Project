
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 12:18:34 AM
// Design Name: 
// Module Name: DECODER_ALU
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

module DECODER_ALU(
input wire [31:0] instruction,
input wire clk, rst, regwr, memread,
output reg [31:0] data, regwrdata
    );
    
wire[31:0] rs1, rs2;
wire[4:0] aluop;
wire[2:0] immsel;
wire zero, halt;
wire wbupdate;
wire memwrite;

DECODER de(
.instruction(instruction),
.aluOperation(aluop),
.immediateSelect(immsel),
.stop(halt)
);

ALU alu(
.operationSelector(aluop),
.operandA(rs1),
.operandB(rs2),
.outputResult(data),
.zeroFlag(zero)
);

RegisterFile regi(
.instruction(instruction),
.reset(rst),
.writeEnable(regwr),
.clock(clk),
.writeData(regwrdata),
.rs1Data(rs1),
.rs2Data(),
.writeBackComplete(wbupdate)
);    

ImmediateGenerator imm(
.instruction_imm(instruction),
.immediateSelect_g(immsel),
.immediateOutput(rs2)
);

DataMemory dmem(
.clock(clk),
.read_enable(memread),
.write_enable(memwrite),
.memory_addr(data),
.write_data(),
.read_data(regwrdata)
);    
  
endmodule
