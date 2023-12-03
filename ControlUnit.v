`timescale 1ns / 1ps

module ControlUnit(
    input wire clk,
    input wire programCounterUpdated,
    input wire instructionFetched,
    input wire registerWrite,
    input wire branchTaken,
    input wire haltExecution,
    input wire  memoryWrite, memoryRead,
    input wire decodeComplete, writeBackComplete,
    input wire [4:0] aluOperation,
    output reg startDecode,
    output reg programCounterWrite,
    output reg startInstructionFetch, startWriteBack
);

    reg [2:0] currentState, nextState;
    parameter Fetch = 3'd0, Decode = 3'd1, WriteBack = 3'd2, UpdatePC = 3'd3, HaltState = 3'd4;

    always @(currentState, haltExecution, programCounterUpdated, decodeComplete, instructionFetched, writeBackComplete, branchTaken, memoryWrite) begin
        case (currentState)
            // Instruction Fetch State
            Fetch: begin
                if (haltExecution)
                    nextState <= HaltState;
                else begin
                    startInstructionFetch <= 1;
                    if (instructionFetched) begin
                        nextState <= Decode;
                        startInstructionFetch <= 0;
                    end
                    else 
                        nextState <= Fetch;
                end
            end
            // Instruction Decode State
            Decode: begin
                if (haltExecution)
                    nextState <= HaltState;
                else begin
                    startDecode <= 1;
                    if (decodeComplete) begin
                        if (branchTaken == 1) begin
                            nextState <= UpdatePC;
                            startDecode <= 0;
                        end
                        else begin
                            nextState <= WriteBack;
                            startDecode <= 0;
                        end
                    end        
                    else
                        nextState <= Decode;                            
                end
            end
            // Write Back State
            WriteBack: begin
                if (haltExecution)
                    nextState <= HaltState;
                else begin
                    startWriteBack <= 1;
                    if (writeBackComplete) begin
                        nextState <= UpdatePC;
                        startWriteBack <= 0;
                    end
                    else if (memoryWrite) begin
                        nextState <= UpdatePC;
                    end    
                    else
                        nextState <= WriteBack;
                end
            end
            // Program Counter Update State
            UpdatePC: begin
                if (haltExecution)
                    nextState <= HaltState;
                else begin
                    programCounterWrite <= 1;
                    if (programCounterUpdated) begin
                        nextState <= Fetch;
                        programCounterWrite <= 0;
                    end    
                    else
                        nextState <= UpdatePC;
                end       
            end
            // Halt State
            HaltState: begin
                nextState <= HaltState;
                startInstructionFetch <= 0;
                startDecode <= 0;
                startWriteBack <= 0;
                programCounterWrite <= 0;
            end
            default: nextState <= Fetch;        
        endcase    
    end
 
    always @(posedge clk) begin
        currentState <= nextState;
    end

endmodule
