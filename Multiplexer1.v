module Multiplexer1(
    input wire select_line,
    input wire [31:0] input_a, input_b,
    output wire [31:0] output_data
);

assign output_data = (select_line == 0) ? input_a : input_b;

endmodule
