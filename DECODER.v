`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 05:47:32 PM
// Design Name: 
// Module Name: DECODER
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


module DECODER( 
input wire clk,
input wire [31:0] inst,
input wire startDecode,
output reg[4:0] aluOperation,
output reg[2:0] immediateSelect,
output reg decodeComplete,
output reg stop, takeBranch,
output reg aluSourceA, aluSourceB,
output reg[1:0] writeBackSelect, programCounterSelect,
output reg enableRegWrite, //PCwrite,
output reg enableMemRead, enableMemWrite,
output reg[2:0] memDataType
);
    
wire[6:0] opcode;
wire[2:0] func3;
wire[6:0] func7;

assign opcode = inst[6:0];
assign func3 = inst[14:12];
assign func7 = inst[31:25];


always@(posedge clk) begin
    if (startDecode) begin
        decodeComplete <= 0;
        aluOperation <= 0;
        immediateSelect <= 0;
        stop <= 0;
        takeBranch <= 0;
        aluSourceA <= 0;
        aluSourceB <= 0;
        writeBackSelect <= 0;
        programCounterSelect <= 0;
        enableRegWrite <= 0;
        //PCwrite <= 0;
        enableMemRead <= 0;
        enableMemWrite <= 0;
        memDataType <= 0;
        case(opcode)
            7'b0110111: begin
            aluOperation <= 5'b00000;//LUI
            immediateSelect <= 3'b000;//imm[31:12]
            aluSourceB <= 1;//imm
            writeBackSelect <= 2;//alu_out
            enableRegWrite <= 1;
            programCounterSelect <= 0;
            end
            7'b0010111: begin
            aluOperation <= 5'b00001;//AUPIC
            immediateSelect <= 3'b000;//imm[31:12]
            aluSourceA <= 0; //get it from PC
            aluSourceB <= 1; //imm
            writeBackSelect <= 2;//alu_out
            enableRegWrite <= 1;
            programCounterSelect <= 0;
            end
            7'b1101111: begin 
            aluOperation <= 5'b00010;//JAL
            immediateSelect <= 3'b001;//imm[20,10:1,11,19:12]
            aluSourceA <= 0; //get it from PC
            aluSourceB <= 1; //imm
            writeBackSelect <= 0;//PC+4
            enableRegWrite <= 1;
            programCounterSelect <= 2;//pc = alu out
            end
            7'b1100111: begin
            aluOperation <= 5'b00010;//JALR
            immediateSelect <= 3'b010;//imm[11:0]
            aluSourceA <= 1; //get it from rs1
            aluSourceB <= 1; //imm
            writeBackSelect <= 0;//PC+4
            enableRegWrite <= 1;
            programCounterSelect <= 2;//pc = alu out
            end
            7'b1100011: begin
                case(func3)
                    3'b000: begin
                    aluOperation <= 5'b00011;//BEQ
                    immediateSelect <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    aluSourceA <= 1; //get it from rs1
                    aluSourceB <= 0; //get it from rs2
                    programCounterSelect <= 1;// pc = pc+imm
                    takeBranch <= 1;
                    end
                    3'b001: begin
                    aluOperation <= 5'b00100;//BNE
                    immediateSelect <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    aluSourceA <= 1; //get it from rs1
                    aluSourceB <= 0; //get it from rs2
                    programCounterSelect <= 1;// pc = pc+imm
                    takeBranch <= 1;
                    end
                    3'b100: begin
                    aluOperation <= 5'b00101;//BLT
                    immediateSelect <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    aluSourceA <= 1; //get it from rs1
                    aluSourceB <= 0; //get it from rs2
                    programCounterSelect <= 1;// pc = pc+imm
                    takeBranch <= 1;
                    end
                    3'b101: begin
                    aluOperation <= 5'b00110;//BGE
                    immediateSelect <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    aluSourceA <= 1; //get it from rs1
                    aluSourceB <= 0; //get it from rs2
                    programCounterSelect <= 1;// pc = pc+imm
                    takeBranch <= 1;
                    end
                    3'b110: begin
                    aluOperation <= 5'b00111;//BLTU
                    immediateSelect <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    aluSourceA <= 1; //get it from rs1
                    aluSourceB <= 0; //get it from rs2
                    programCounterSelect <= 1;// pc = pc+imm
                    takeBranch <= 1;
                    end
                    3'b111: begin
                    aluOperation <= 5'b01000;//BGEU
                    immediateSelect <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    aluSourceA <= 1; //get it from rs1
                    aluSourceB <= 0; //get it from rs2
                    programCounterSelect <= 1;// pc = pc+imm
                    takeBranch <= 1;
                    end
                    default: aluOperation <= 5'b11111; //out of aluop range
                endcase
            end
            7'b0000011: begin
                case(func3)
                    3'b000: begin
                    aluOperation <= 5'b00010;//LB
                    immediateSelect <= 3'b010;//imm[11:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    writeBackSelect <= 1;// from DMEM
                    enableRegWrite <= 1;
                    enableMemRead <= 1;
                    memDataType <= 3'b000;//byte, sign extended 
                    end
                    3'b001: begin
                    aluOperation <= 5'b00010;//LH
                    immediateSelect <= 3'b010;//imm[11:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    writeBackSelect <= 1;// from DMEM
                    enableRegWrite <= 1;
                    enableMemRead <= 1;
                    memDataType <= 3'b001;//half word, sign extended
                    end
                    3'b010: begin
                    aluOperation <= 5'b00010;//LW
                    immediateSelect <= 3'b010;//imm[11:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    writeBackSelect <= 1;// from DMEM
                    enableRegWrite <= 1;
                    enableMemRead <= 1;
                    memDataType <= 3'b010;//word, sign extended
                    end
                    3'b100: begin
                    aluOperation <= 5'b00010;//LBU
                    immediateSelect <= 3'b010;//imm[11:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    writeBackSelect <= 1;// from DMEM
                    enableRegWrite <= 1;
                    enableMemRead <= 1;
                    memDataType <= 3'b011;//byte, zero extended
                    end
                    3'b101: begin
                    aluOperation <= 5'b00010;//LHU
                    immediateSelect <= 3'b010;//imm[11:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    writeBackSelect <= 1;// from DMEM
                    enableRegWrite <= 1;
                    enableMemRead <= 1;
                    memDataType <= 3'b100;//half word, zero extended
                    end
                    default: aluOperation <= 5'b11111;
                endcase
            end
            7'b0100011: begin
                case(func3)
                    3'b000: begin
                    aluOperation <= 5'b00010;//SB
                    immediateSelect <= 3'b100;//imm[11:5]imm[4:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    enableMemWrite <= 1;
                    memDataType <= 3'b000;//SB
                    end
                    3'b001: begin
                    aluOperation <= 5'b00010;//SH
                    immediateSelect <= 3'b100;//imm[11:5]imm[4:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    enableMemWrite <= 1;
                    memDataType <= 3'b001;//SH
                    end
                    3'b010: begin
                    aluOperation <= 5'b00010;//SW, this output is just rs1+imm, the type of rs2 will not be controlled by this module
                    immediateSelect <= 3'b100;//imm[11:5]imm[4:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    enableMemWrite <= 1;
                    memDataType <= 3'b010;//SW
                    end
                    default: aluOperation <= 5'b11111;
                endcase
            end
            7'b0010011: begin
                case(func3)
                    3'b000: begin
                    aluOperation <= 5'b00010;//ADDI
                    immediateSelect <= 3'b010;//imm[11:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;//from imm
                    writeBackSelect <= 2;// from alu out
                    enableRegWrite <= 1;
                    end
                    3'b001: begin
                    aluOperation <= 5'b01110;//SLLI
                    immediateSelect <= 3'b010;//imm[11:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    writeBackSelect <= 2;// from alu out
                    enableRegWrite <= 1;
                    end
                    3'b010: begin
                    aluOperation <= 5'b01001;//SLTI
                    immediateSelect <= 3'b010;//imm[11:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    writeBackSelect <= 2;// from alu out
                    enableRegWrite <= 1;
                    end
                    3'b011: begin
                    aluOperation <= 5'b01010;//SLTIU
                    immediateSelect <= 3'b010;//imm[11:0]
                    aluSourceA <= 1;//from rs1
                    aluSourceB <= 1;
                    writeBackSelect <= 2;// from alu out
                    enableRegWrite <= 1;
                    end
                    3'b100: begin
                    aluOperation <= 5'b01011;//XORI
                    immediateSelect <= 3'b010;//imm[11:0]
                    aluSourceA <= 1;
                    aluSourceB <= 1;
                    writeBackSelect <= 2;// from alu out
                    enableRegWrite <= 1;
                    end
                    3'b101: begin
                    if(func7 == 7'b0100000) begin
                        aluOperation <= 5'b10000;//SRAI
                        immediateSelect <= 3'b010;//imm[11:0]
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 1;
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    else if(func7 == 0) begin
                        aluOperation <= 5'b01111;//SRLI
                        immediateSelect <= 3'b010;//imm[11:0]
                        aluSourceA <= 1;//from rs1 
                        aluSourceB <= 1;
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    else begin
                        aluOperation <= 5'b11111;
                    end
                    end    
                    3'b110: begin
                        aluOperation <= 5'b01100;//ORI
                        immediateSelect <= 3'b010;//imm[11:0]
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 1;
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    3'b111: begin
                        aluOperation <= 5'b01101;//ANDI
                        immediateSelect <= 3'b010;//imm[11:0]
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 1;
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                endcase
            end
            7'b0110011: begin
                case(func3)
                    3'b000: begin
                    if(func7 == 0) begin
                        aluOperation <= 5'b000010;//ADD
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    else if(func7 == 7'b0100000) begin
                        aluOperation <= 5'b10001;//SUB
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    else begin
                        aluOperation <= 5'b11111;
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    end
                    3'b001: begin
                        aluOperation <= 5'b01110;//SLL
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    3'b010: begin
                        aluOperation <= 5'b01001;//SLT
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    3'b011: begin
                        aluOperation <= 5'b01010;//SLTU
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    3'b100: begin
                        aluOperation <= 5'b01011;//XOR
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    3'b101: begin
                    if(func7 == 0) begin
                        aluOperation <= 5'b01111;//SRL
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    else if (func7 == 7'b0100000) begin
                        aluOperation <= 5'b10000;//SRA
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end    
                    else
                        aluOperation <= 5'b11111;
                    end
                    3'b110: begin
                        aluOperation <= 5'b01100;//OR
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    3'b111: begin
                        aluOperation <= 5'b01101;//AND
                        aluSourceA <= 1;//from rs1
                        aluSourceB <= 0;//from rs2
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                    end
                    endcase
                end
            7'b0001111: begin
                        aluOperation <= 5'b10010;//FENCE, act as ADDI r0, r0, 0
                        immediateSelect <= 3'b111;//out of range so imm will be 0
                        aluSourceA <= 1;//from rs1, but not important here, because in the ALU, 5b10010 is 0+input2
                        aluSourceB <= 1;//from imm
                        writeBackSelect <= 2;// from alu out
                        enableRegWrite <= 1;
                        end
            7'b1110011: begin
                        stop <= 1;//ECALL and EBREAK
                        end   
        endcase
        decodeComplete <= 1;
    end
    else 
        decodeComplete <= 0;
end    
    
    
    
endmodule