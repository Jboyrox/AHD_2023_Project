`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2023 10:18:17 AM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input clk, 
    write_enable, 
    reset,
    input [31:0] new_address, 
    output reg [31:0] current_address,
    output reg address_updated
);

    // Initial program counter value
    reg [31:0] initial_address = 32'h01000000;
    
    always @(posedge clk) begin
        if (reset) begin
            // Reset condition
            current_address <= initial_address;
            address_updated <= 1'b1;
        end 
        else if (write_enable) begin
            // Update the program counter
            current_address <= new_address;
            address_updated <= 1'b1;
        end 
        else begin
            // Maintain current address, no update
            current_address <= current_address;
            address_updated <= 1'b0;
        end
    end
endmodule