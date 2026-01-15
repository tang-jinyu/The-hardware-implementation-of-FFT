`timescale  1ns/1ps
    module multiplier#
    (
        parameter   N = 16,
        parameter   Q = 8
    )
    (
        input                  clk,
        input                  rst,
        input [N-1:0]          A  ,
        input [N-1:0]          B  ,

        output reg [N-1:0]     C  

    );

    reg   [2*N-1:0]     P    ;
    reg   [N-1:0]       temp1;
    reg   [N-1:0]       temp2;
    reg   [N-1:0]       temp3;

    always@(negedge clk or posedge rst)begin
    if(rst)begin
        C      =  0;
        P      =  0;
        temp1  =  0;
        temp2  =  0;
        temp3  =  0;
    end
    else begin
        if(A[N-1] == 0 && B[N-1] == 0)begin
            //(+,+)
            temp1 = 0;
            temp2 = 0;
            temp3 = 0;
            P     = A * B;
            C     = P[N-1+Q:Q];
        end
        if(A[N-1] == 1 && B[N-1] == 0)begin
            //(-,+)
            temp1 = ~A + 1'b1;
            temp2 = 0;
            P     = temp1 * B;
            temp3 = P[N-1+Q:Q];
            C     = ~temp3 + 1'b1;
        end
        if(A[N-1] == 0 && B[N-1] == 1)begin
            //(+,-)
            temp2 = ~B + 1'b1;
            temp1 = 0;
            P     = temp2 * A;
            temp3 = P[N-1+Q:Q];
            C     = ~temp3 + 1'b1;
        end
        if(A[N-1] == 1 && B[N-1] == 1)begin
            //(-,-)
            temp2 = ~B + 1'b1;
            temp1 = ~A + 1'b1;
            P     = temp2 * temp1;
            temp3 = 0;
            C     = P[N-1+Q:Q];
        end
    end
    end
    endmodule

