`timescale 1ns / 1ps

module RegisterFile(
    input wire writeBackEnable, reset, writeEnable, clock,
    input wire [31:0] instruction, writeData,
    output reg [31:0] rs1Data, rs2Data,
    output reg writeBackComplete
);

parameter REG_SIZE = 32;
parameter ADDR_BITS = 5;
parameter DATA_WIDTH = 32;

reg [DATA_WIDTH-1:0] registers[REG_SIZE-1:0];

integer i;
initial begin
    for (i = 0; i < REG_SIZE; i = i + 1) begin
        registers[i] = 0;
    end
end

wire [ADDR_BITS-1:0] rs1Addr, rs2Addr, writeAddr;
assign rs1Addr = instruction[19:15];
assign rs2Addr = instruction[24:20];
assign writeAddr = instruction[11:7];

always @(posedge clock) begin
    if (reset) begin
        writeBackComplete <= 0;
        for (i = 0; i < REG_SIZE; i = i + 1) begin
            registers[i] <= 0;
        end
    end else if (writeBackEnable) begin
        if (writeEnable) begin
            if (writeAddr != 0)
                registers[writeAddr] <= writeData;
            writeBackComplete <= 1;
        end else begin
            writeBackComplete <= 0;
        end
    end else begin
        writeBackComplete <= 0;
    end
end

always @(*) begin
    rs1Data <= registers[rs1Addr];
    rs2Data <= registers[rs2Addr];    
end
    
endmodule
