`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2022 02:26:50 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:no copilot
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input wire [4:0] operationSelector,
    input wire[31:0] operandA,
    input wire [31:0] operandB, 
    output reg[31:0] outputResult,
    output reg zeroFlag
    );
    

 
always@(*) begin
    case(operationSelector)
    5'b00000: outputResult <= {operandB[31:12], 12'b0}; //LUI
    5'b00001: outputResult <= operandA+{operandB[31:12], 12'b0};// AUPIC
    5'b00010: outputResult <= operandA+operandB;//JAL,JALR,LB,LH,LBU,LHU,LW,SB,SH,SW,ADD,ADDI
    5'b00011: zeroFlag <= (operandA == operandB)?1 : 0;//BEQ
    5'b00100: zeroFlag <= (operandA == operandB)?0 : 1;//BNE
    5'b00101: zeroFlag <= ($signed(operandA) < $signed(operandB))?1 : 0;//BLT 
    5'b00110: zeroFlag <= ($signed(operandA) >= $signed(operandB))?1 : 0;//BGE 
    5'b00111: zeroFlag <= (operandA < operandB)?1 : 0;//BLTU
    5'b01000: zeroFlag <= (operandA >= operandB)?1 : 0;//BGEU
    5'b01001: outputResult <= ($signed(operandA) < $signed(operandB))?1 : 0; //SLTI,SLT
    5'b01010: outputResult <= (operandA < operandB)?1 : 0;//SLTIU,SLTU
    5'b01011: outputResult <= operandA ^ operandB; //XORI,XOR
    5'b01100: outputResult <= operandA | operandB; //ORI,OR
    5'b01101: outputResult <= operandA & operandB; //ANDI,AND
    5'b01110: begin //SLLI, SLL
    case(operandB[4:0])
       5'b00000: outputResult <= operandA;
       5'b00001: outputResult <= {operandA[30:0],1'b0};
       5'b00010: outputResult <= {operandA[29:0],2'b0}; 
       5'b00011: outputResult <= {operandA[28:0],3'b0};
       5'b00100: outputResult <= {operandA[27:0],4'b0};
       5'b00101: outputResult <= {operandA[26:0],5'b0};
       5'b00110: outputResult <= {operandA[25:0],6'b0};
       5'b00111: outputResult <= {operandA[24:0],7'b0};
       5'b01000: outputResult <= {operandA[23:0],8'b0};
       5'b01001: outputResult <= {operandA[22:0],9'b0};
       5'b01010: outputResult <= {operandA[21:0],10'b0};
       5'b01011: outputResult <= {operandA[20:0],11'b0};
       5'b01100: outputResult <= {operandA[19:0],12'b0};
       5'b01101: outputResult <= {operandA[18:0],13'b0};
       5'b01110: outputResult <= {operandA[17:0],14'b0};
       5'b01111: outputResult <= {operandA[16:0],15'b0};
       5'b10000: outputResult <= {operandA[15:0],16'b0};
       5'b10001: outputResult <= {operandA[14:0],17'b0};
       5'b10010: outputResult <= {operandA[13:0],18'b0};
       5'b10011: outputResult <= {operandA[12:0],19'b0};
       5'b10100: outputResult <= {operandA[11:0],20'b0};
       5'b10101: outputResult <= {operandA[10:0],21'b0};
       5'b10110: outputResult <= {operandA[09:0],22'b0};
       5'b10111: outputResult <= {operandA[08:0],23'b0};
       5'b11000: outputResult <= {operandA[07:0],24'b0};
       5'b11001: outputResult <= {operandA[06:0],25'b0};
       5'b11010: outputResult <= {operandA[05:0],26'b0};
       5'b11011: outputResult <= {operandA[04:0],27'b0};
       5'b11100: outputResult <= {operandA[03:0],28'b0};
       5'b11101: outputResult <= {operandA[02:0],29'b0};
       5'b11110: outputResult <= {operandA[01:0],30'b0};
       5'b11111: outputResult <= {operandA[0],31'b0};
    endcase
    end
            
    5'b01111: begin //SRLI,SRL
    case(operandB[4:0])
       5'b00000: outputResult <= operandA;
       5'b00001: outputResult <= {1'b0,operandA[31:5'b00001]};
       5'b00010: outputResult <= {2'b0,operandA[31:5'b00010]};
       5'b00011: outputResult <= {3'b0,operandA[31:5'b00011]};
       5'b00100: outputResult <= {4'b0,operandA[31:5'b00100]}; 
       5'b00101: outputResult <= {5'b0,operandA[31:5'b00101]};
       5'b00110: outputResult <= {6'b0,operandA[31:5'b00110]};
       5'b00111: outputResult <= {7'b0,operandA[31:5'b00111]};
       5'b01000: outputResult <= {8'b0,operandA[31:5'b01000]};
       5'b01001: outputResult <= {9'b0,operandA[31:5'b01001]};
       5'b01010: outputResult <= {10'b0,operandA[31:5'b01010]};
       5'b01011: outputResult <= {11'b0,operandA[31:5'b01011]};
       5'b01100: outputResult <= {12'b0,operandA[31:5'b01100]};
       5'b01101: outputResult <= {13'b0,operandA[31:5'b01101]};
       5'b01110: outputResult <= {14'b0,operandA[31:5'b01110]};
       5'b01111: outputResult <= {15'b0,operandA[31:5'b01111]};
       5'b10000: outputResult <= {16'b0,operandA[31:5'b10000]};
       5'b10001: outputResult <= {17'b0,operandA[31:5'b10001]};
       5'b10010: outputResult <= {18'b0,operandA[31:5'b10010]};
       5'b10011: outputResult <= {19'b0,operandA[31:5'b10011]};
       5'b10100: outputResult <= {20'b0,operandA[31:5'b10100]};
       5'b10101: outputResult <= {21'b0,operandA[31:5'b10101]};
       5'b10110: outputResult <= {22'b0,operandA[31:5'b10110]};
       5'b10111: outputResult <= {23'b0,operandA[31:5'b10111]};
       5'b11000: outputResult <= {24'b0,operandA[31:5'b11000]};
       5'b11001: outputResult <= {25'b0,operandA[31:5'b11001]};
       5'b11010: outputResult <= {26'b0,operandA[31:5'b11010]};
       5'b11011: outputResult <= {27'b0,operandA[31:5'b11011]};
       5'b11100: outputResult <= {28'b0,operandA[31:5'b11100]};
       5'b11101: outputResult <= {29'b0,operandA[31:5'b11101]};
       5'b11110: outputResult <= {30'b0,operandA[31:5'b11110]};
       5'b11111: outputResult <= {31'b0,operandA[31:5'b11111]};
    endcase
    end
    
    5'b10000: begin //SRAI,SRA
    case(operandB[4:0])
       5'b00000: outputResult <= operandA;
       5'b00001: outputResult <= {operandA[31],operandA[31:5'b00001]}; 
       5'b00010: outputResult <= {{2{operandA[31]}},operandA[31:5'b00010]};
       5'b00011: outputResult <= {{3{operandA[31]}},operandA[31:5'b00011]};
       5'b00100: outputResult <= {{4{operandA[31]}},operandA[31:5'b00100]};
       5'b00101: outputResult <= {{5{operandA[31]}},operandA[31:5'b00101]};
       5'b00110: outputResult <= {{6{operandA[31]}},operandA[31:5'b00110]};
       5'b00111: outputResult <= {{7{operandA[31]}},operandA[31:5'b00111]};
       5'b01000: outputResult <= {{8{operandA[31]}},operandA[31:5'b01000]};
       5'b01001: outputResult <= {{9{operandA[31]}},operandA[31:5'b01001]};
       5'b01010: outputResult <= {{10{operandA[31]}},operandA[31:5'b01010]};
       5'b01011: outputResult <= {{11{operandA[31]}},operandA[31:5'b01011]};
       5'b01100: outputResult <= {{12{operandA[31]}},operandA[31:5'b01100]};
       5'b01101: outputResult <= {{13{operandA[31]}},operandA[31:5'b01101]};
       5'b01110: outputResult <= {{14{operandA[31]}},operandA[31:5'b01110]};
       5'b01111: outputResult <= {{15{operandA[31]}},operandA[31:5'b01111]};
       5'b10000: outputResult <= {{16{operandA[31]}},operandA[31:5'b10000]};
       5'b10001: outputResult <= {{17{operandA[31]}},operandA[31:5'b10001]};
       5'b10010: outputResult <= {{18{operandA[31]}},operandA[31:5'b10010]};
       5'b10011: outputResult <= {{19{operandA[31]}},operandA[31:5'b10011]};
       5'b10100: outputResult <= {{20{operandA[31]}},operandA[31:5'b10100]};
       5'b10101: outputResult <= {{21{operandA[31]}},operandA[31:5'b10101]};
       5'b10110: outputResult <= {{22{operandA[31]}},operandA[31:5'b10110]};
       5'b10111: outputResult <= {{23{operandA[31]}},operandA[31:5'b10111]};
       5'b11000: outputResult <= {{24{operandA[31]}},operandA[31:5'b11000]};
       5'b11001: outputResult <= {{25{operandA[31]}},operandA[31:5'b11001]};
       5'b11010: outputResult <= {{26{operandA[31]}},operandA[31:5'b11010]};
       5'b11011: outputResult <= {{27{operandA[31]}},operandA[31:5'b11011]};
       5'b11100: outputResult <= {{28{operandA[31]}},operandA[31:5'b11100]};
       5'b11101: outputResult <= {{29{operandA[31]}},operandA[31:5'b11101]};
       5'b11110: outputResult <= {{30{operandA[31]}},operandA[31:5'b11110]};
       5'b11111: outputResult <= {{31{operandA[31]}},operandA[31:5'b11111]};
    endcase
    end
                   
    5'b10001: outputResult <=  operandA - operandB; //SUB
    5'b10010: outputResult <= 0 + operandB;
    5'b10011: outputResult <= operandA + operandB - 32'h01000000;//JAL,JALR
    default: begin
             zeroFlag <= 0;
             outputResult <= 32'h0;
             end
    endcase
     
end




        
endmodule