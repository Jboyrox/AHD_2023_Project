`timescale 1ns / 1ps


module ImmediateGenerator(
    input wire [31:0] instruction,
    input wire [2:0] immediateSelect,
    output reg [31:0] immediateOutput
);

always @(*) begin
    case (immediateSelect)
        3'b000: immediateOutput <= {instruction[31:12], 12'b0}; // U type
        3'b001: immediateOutput <= {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}; // J type, sign extended
        3'b010: immediateOutput <= {{20{instruction[31]}}, instruction[31:20]}; // I type, sign extended
        3'b011: immediateOutput <= {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // B type, sign extended 
        3'b100: immediateOutput <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // S type, sign extended
        default: immediateOutput <= 0;
    endcase
end

endmodule