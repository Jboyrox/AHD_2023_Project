module ALU_testbench();
reg[4:0] operationSelector;
reg[31:0] operandA;
reg[31:0] operandB;

wire[31:0] outputResult;
wire zeroFlag;

ALU dut (
.operationSelector(operationSelector),
.operandA(operandA),
.operandB(operandB),
.outputResult(outputResult),
.zeroFlag(zeroFlag)
);

initial begin
operationSelector = 5'b01110;//this is SLL, for SLLI we need to connect to the IMMGEN, which I did, but not in this testbench
operandA = 32'h0000000f;
operandB = 32'h0000000f;// imm will be 15
end

initial begin
#10; 
operandB = 32'hf000000f;// added signed bits in front, signed = -268435441, unsigned = 4026531855 
operationSelector = 5'b00101;//this is BLT, with signed arguments, 15>-268435441, so zeroFlag should be 0
#10 operationSelector = 5'b00111;// this is BLTU, unsigned branch if less then, 15< 4026531855 so zeroFlag should be 1, we can see the difference between BLT and BLTU
#10 operationSelector = 5'b00010;//JAL,JALR,LB,LH,LBU,LHU,LW,SB,SH,SW,ADD,ADDI
end

endmodule
