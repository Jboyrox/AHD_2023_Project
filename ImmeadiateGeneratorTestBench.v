`timescale 1ns / 1ps

module ImmediateGeneratorTestbench();
reg [31:0] instructionInput;
reg [2:0] immediateTypeSelector;
wire [31:0] immediateValueOutput;

ImmediateGenerator dut(
    .instruction(instructionInput),
    .immediateSelect(immediateTypeSelector),
    .immediateOutput(immediateValueOutput)
);

initial begin
    immediateTypeSelector = 0;
    instructionInput = 32'b00000000000000000000000010110111; // U type
    
    #5; 
    immediateTypeSelector = 1;
    instructionInput = 32'b00000100000000000000000011101111; // J type 
   
    #5;
    immediateTypeSelector = 2;
    instructionInput = 32'b00000100000000001000000100000011; // I type
    
    #5; 
    immediateTypeSelector = 3;
    instructionInput = 32'b00000100001000001000000001100011; // B type 
   
    #5;
    immediateTypeSelector = 4;
    instructionInput = 32'b00000100001000001000000000100011; // S type
   
    #5 immediateTypeSelector = 5; // out of range, output 0
    #5 $stop;
end

endmodule
