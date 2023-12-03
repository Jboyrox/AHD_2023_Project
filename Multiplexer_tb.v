`timescale 1ns / 1ps

module Multiplexer_tb();
    reg select_line;
    reg[1:0] selection;
    reg[31:0] input_a1, input_b1, input_option1, input_option2, input_option3;
    wire[31:0] output_data1, output_result2;

    Multiplexer1 dut1(
        .select_line(select_line),
        .input_a(input_a1),
        .input_b(input_b1),
        .output_data(output_data1)
    );

    Multiplexer2 dut2(
        .selection(selection),
        .input_option1(input_option1),
        .input_option2(input_option2),
        .input_option3(input_option3),
        .output_result(output_result2)
    );

    initial begin
        // Initialize inputs
        select_line = 0;
        selection = 2;

        input_a1 = 32'd10;
        input_b1 = 32'd20;
        input_option1 = 32'd30;
        input_option2 = 32'd40;
        input_option3 = 32'd50;

       
    end

endmodule
