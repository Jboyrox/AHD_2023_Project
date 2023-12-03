`timescale 1ns / 1ps

module RegisterFile_testbench();
    reg clock, reset, writeEnable;
    reg [31:0] instruction, writeData;
    wire [31:0] rs1Data, rs2Data;
    wire writeBackComplete;

    // Instantiate the RegisterFile module
    RegisterFile dut(
        .clock(clock),
        .reset(reset),
        .writeEnable(writeEnable),
        .instruction(instruction),
        .writeData(writeData),
        .rs1Data(rs1Data),
        .rs2Data(rs2Data),
        .writeBackComplete(writeBackComplete)
    );

    initial begin
        clock = 0;
        reset = 1;
        writeEnable = 0;
    end

    always #5 clock = ~clock;

    initial begin
        #5 instruction = 32'b000000000000_00110_00111_000_00010_0110011; // Example instruction
        #5 reset = 0;
        #5 writeData = 32'hffffffff;
        #5 writeEnable = 1;
        #5 instruction = 32'b000000000000_00010_00100_000_00010_0110011; // Another example instruction
        // Additional test cases can be added here
    end
endmodule
