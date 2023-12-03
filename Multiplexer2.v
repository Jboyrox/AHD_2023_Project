module Multiplexer2(
    input wire [1:0] selection,
    input wire [31:0] input_option1, input_option2, input_option3,
    output reg [31:0] output_result
);

always @(*) begin
    case(selection)
        2'b00: output_result = input_option1;
        2'b01: output_result = input_option2;
        2'b10: output_result = input_option3;
        default: output_result = 32'h00000000;
    endcase
end

endmodule
