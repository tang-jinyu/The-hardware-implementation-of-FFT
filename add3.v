`timescale 1ns/1ps
module add3#
(
    parameter N = 16
)
(
    input           clk,
    input           rst,
    input   [N-1:0] A  ,
    input   [N-1:0] B  ,
    input   [N-1:0] C  ,
    output reg [N-1:0] D  
);
    always @(posedge clk or negedge rst)begin
        if(rst)begin
            D = 0;
        end
        else begin
            D = A + B + C;
        end 
    end
endmodule