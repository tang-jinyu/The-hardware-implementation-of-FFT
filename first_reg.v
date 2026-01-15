`timescale 1ns/1ps
module first_reg #
(
    parameter   N=16,
    parameter   Q=8
)
(
    input               clk2,
    input               rst,
    input      [N-1:0]  in,

    output reg [N-1:0]  in0_r_0 ,
    output reg [N-1:0]  in1_r_0 ,
    output reg [N-1:0]  in2_r_0 ,
    output reg [N-1:0]  in3_r_0 ,
    output reg [N-1:0]  in4_r_0 ,
    output reg [N-1:0]  in5_r_0 ,
    output reg [N-1:0]  in6_r_0 ,
    output reg [N-1:0]  in7_r_0 ,
    output reg [N-1:0]  in8_r_0 ,
    output reg [N-1:0]  in9_r_0 ,
    output reg [N-1:0]  in10_r_0,
    output reg [N-1:0]  in11_r_0,
    output reg [N-1:0]  in12_r_0,
    output reg [N-1:0]  in13_r_0,
    output reg [N-1:0]  in14_r_0,
    output reg [N-1:0]  in15_r_0,
    output reg [N-1:0]  in16_r_0,
    output reg [N-1:0]  in17_r_0,
    output reg [N-1:0]  in18_r_0,
    output reg [N-1:0]  in19_r_0,
    output reg [N-1:0]  in20_r_0,
    output reg [N-1:0]  in21_r_0,
    output reg [N-1:0]  in22_r_0,
    output reg [N-1:0]  in23_r_0,
    output reg [N-1:0]  in24_r_0,
    output reg [N-1:0]  in25_r_0,
    output reg [N-1:0]  in26_r_0,
    output reg [N-1:0]  in27_r_0,
    output reg [N-1:0]  in28_r_0,
    output reg [N-1:0]  in29_r_0,
    output reg [N-1:0]  in30_r_0,
    output reg [N-1:0]  in31_r_0
);

    reg [N-1:0] reg_array [0:31];
    reg [4:0]   counter;
    integer i;

    always@(posedge clk2 or posedge rst)begin
        if(rst)begin
            for(i=0;i<32;i=i+1)begin
            reg_array[i] <= 0;
            end
            counter <= 0;
        end 
    else begin
        reg_array[counter] <= in;
        if(counter == 5'd31)begin 
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    end 
    end
    always@(*)begin
        in0_r_0   = reg_array[0];
        in1_r_0   = reg_array[1];
        in2_r_0   = reg_array[2];
        in3_r_0   = reg_array[3];
        in4_r_0   = reg_array[4];
        in5_r_0   = reg_array[5];
        in6_r_0   = reg_array[6];
        in7_r_0   = reg_array[7];
        in8_r_0   = reg_array[8];
        in9_r_0   = reg_array[9];
        in10_r_0  = reg_array[10];
        in11_r_0  = reg_array[11];
        in12_r_0  = reg_array[12];
        in13_r_0  = reg_array[13];
        in14_r_0  = reg_array[14];
        in15_r_0  = reg_array[15];
        in16_r_0  = reg_array[16];
        in17_r_0  = reg_array[17];
        in18_r_0  = reg_array[18];
        in19_r_0  = reg_array[19];
        in20_r_0  = reg_array[20];
        in21_r_0  = reg_array[21];
        in22_r_0  = reg_array[22];
        in23_r_0  = reg_array[23];
        in24_r_0  = reg_array[24];
        in25_r_0  = reg_array[25];
        in26_r_0  = reg_array[26];
        in27_r_0  = reg_array[27];
        in28_r_0  = reg_array[28];
        in29_r_0  = reg_array[29];
        in30_r_0  = reg_array[30];
        in31_r_0  = reg_array[31];
    end

    
endmodule
        
