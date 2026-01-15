`timescale 1ns/1ps

module Clk_div #
(
    parameter   DIVISOR = 5//顶层中参数还要传递：如果顶层传递了其他参数就会覆盖这里的取值，没传递的话就用这个值
)
(
    input       rst,
    input       clk_in,
    output reg  clk_out
);
    reg [3:0]   counter;//4位计数器从0-15

    always @(posedge clk_in or posedge rst)begin
        if(rst)begin
            counter <= 0;
            clk_out <= 0;
        end
        else begin
            counter <= counter + 1;

            if(counter >= (DIVISOR-1))
            counter <= 0;

            clk_out <= (counter < DIVISOR/2) ? (1'b1):(1'b0);

        end
    end

endmodule