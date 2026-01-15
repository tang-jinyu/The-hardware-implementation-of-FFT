`timescale 1ns/1ps
module post_reg #
(
    parameter   N=16,
    parameter   Q=8
)
(
    input               clk2,
    input               rst,
    input               start_output,
    input   [N-1:0]     out0_r,
    input   [N-1:0]     out0_i,
    input   [N-1:0]     out1_r,
    input   [N-1:0]     out1_i,
    input   [N-1:0]     out2_r,
    input   [N-1:0]     out2_i,
    input   [N-1:0]     out3_r,
    input   [N-1:0]     out3_i,
    input   [N-1:0]     out4_r,
    input   [N-1:0]     out4_i,
    input   [N-1:0]     out5_r,
    input   [N-1:0]     out5_i,
    input   [N-1:0]     out6_r,
    input   [N-1:0]     out6_i,
    input   [N-1:0]     out7_r,
    input   [N-1:0]     out7_i,
    input   [N-1:0]     out8_r,
    input   [N-1:0]     out8_i,
    input   [N-1:0]     out9_r,
    input   [N-1:0]     out9_i,
    input   [N-1:0]     out10_r,
    input   [N-1:0]     out10_i,
    input   [N-1:0]     out11_r,
    input   [N-1:0]     out11_i,
    input   [N-1:0]     out12_r,
    input   [N-1:0]     out12_i,
    input   [N-1:0]     out13_r,
    input   [N-1:0]     out13_i,
    input   [N-1:0]     out14_r,
    input   [N-1:0]     out14_i,
    input   [N-1:0]     out15_r,
    input   [N-1:0]     out15_i,
    input   [N-1:0]     out16_r,
    input   [N-1:0]     out16_i,
    input   [N-1:0]     out17_r,
    input   [N-1:0]     out17_i,
    input   [N-1:0]     out18_r,
    input   [N-1:0]     out18_i,
    input   [N-1:0]     out19_r,
    input   [N-1:0]     out19_i,
    input   [N-1:0]     out20_r,
    input   [N-1:0]     out20_i,
    input   [N-1:0]     out21_r,
    input   [N-1:0]     out21_i,
    input   [N-1:0]     out22_r,
    input   [N-1:0]     out22_i,
    input   [N-1:0]     out23_r,
    input   [N-1:0]     out23_i,
    input   [N-1:0]     out24_r,
    input   [N-1:0]     out24_i,
    input   [N-1:0]     out25_r,
    input   [N-1:0]     out25_i,
    input   [N-1:0]     out26_r,
    input   [N-1:0]     out26_i,
    input   [N-1:0]     out27_r,
    input   [N-1:0]     out27_i,
    input   [N-1:0]     out28_r,
    input   [N-1:0]     out28_i,
    input   [N-1:0]     out29_r,
    input   [N-1:0]     out29_i,
    input   [N-1:0]     out30_r,
    input   [N-1:0]     out30_i,
    input   [N-1:0]     out31_r,
    input   [N-1:0]     out31_i,

//---------串行输出接口----------//
    output reg [N-1:0]   serial_out,
    output reg           out_valid,
    output reg           out_type,
    output reg           output_busy,
    output reg           output_done

);

    reg [N-1:0] reg_array_r [0:31];
    reg [N-1:0] reg_array_i [0:31];
    reg [5:0]   out_counter;
    reg [2:0]   state;               // 状态机状态
    reg [15:0]  wait_counter;        // 等待FFT计算完成的计数器
    localparam S_IDLE        = 3'b000;  // 空闲状态
    localparam S_WAIT_FFT    = 3'b001;  // 等待FFT计算完成
    localparam S_OUTPUT_REAL = 3'b010;  // 输出实部
    localparam S_OUTPUT_IMAG = 3'b011;  // 输出虚部
    localparam S_DONE        = 3'b100;  // 输出完成

    always@(*)begin
        reg_array_r[0]    =   out0_r ;
        reg_array_r[1]    =   out1_r ;
        reg_array_r[2]    =   out2_r ;
        reg_array_r[3]    =   out3_r ;
        reg_array_r[4]    =   out4_r ;
        reg_array_r[5]    =   out5_r ;
        reg_array_r[6]    =   out6_r ;
        reg_array_r[7]    =   out7_r ;
        reg_array_r[8]    =   out8_r ;
        reg_array_r[9]    =   out9_r ;
        reg_array_r[10]   =   out10_r;
        reg_array_r[11]   =   out11_r;
        reg_array_r[12]   =   out12_r;
        reg_array_r[13]   =   out13_r;
        reg_array_r[14]   =   out14_r;
        reg_array_r[15]   =   out15_r;
        reg_array_r[16]   =   out16_r;
        reg_array_r[17]   =   out17_r;
        reg_array_r[18]   =   out18_r;
        reg_array_r[19]   =   out19_r;
        reg_array_r[20]   =   out20_r;
        reg_array_r[21]   =   out21_r;
        reg_array_r[22]   =   out22_r;
        reg_array_r[23]   =   out23_r;
        reg_array_r[24]   =   out24_r;
        reg_array_r[25]   =   out25_r;
        reg_array_r[26]   =   out26_r;
        reg_array_r[27]   =   out27_r;
        reg_array_r[28]   =   out28_r;
        reg_array_r[29]   =   out29_r;
        reg_array_r[30]   =   out30_r;
        reg_array_r[31]   =   out31_r;

        reg_array_i[0]    =   out0_i ;
        reg_array_i[1]    =   out1_i ;
        reg_array_i[2]    =   out2_i ;
        reg_array_i[3]    =   out3_i ;
        reg_array_i[4]    =   out4_i ;
        reg_array_i[5]    =   out5_i ;
        reg_array_i[6]    =   out6_i ;
        reg_array_i[7]    =   out7_i ;
        reg_array_i[8]    =   out8_i ;
        reg_array_i[9]    =   out9_i ;
        reg_array_i[10]   =   out10_i;
        reg_array_i[11]   =   out11_i;
        reg_array_i[12]   =   out12_i;
        reg_array_i[13]   =   out13_i;
        reg_array_i[14]   =   out14_i;
        reg_array_i[15]   =   out15_i;
        reg_array_i[16]   =   out16_i;
        reg_array_i[17]   =   out17_i;
        reg_array_i[18]   =   out18_i;
        reg_array_i[19]   =   out19_i;
        reg_array_i[20]   =   out20_i;
        reg_array_i[21]   =   out21_i;
        reg_array_i[22]   =   out22_i;
        reg_array_i[23]   =   out23_i;
        reg_array_i[24]   =   out24_i;
        reg_array_i[25]   =   out25_i;
        reg_array_i[26]   =   out26_i;
        reg_array_i[27]   =   out27_i;
        reg_array_i[28]   =   out28_i;
        reg_array_i[29]   =   out29_i;
        reg_array_i[30]   =   out30_i;
        reg_array_i[31]   =   out31_i;
    end

    always @(posedge clk2 or posedge rst) begin
    if (rst) begin
        state <= S_IDLE;
        out_counter <= 0;
        wait_counter <= 0;
        serial_out <= 0;
        out_valid <= 0;
        out_type <= 0;
        output_busy <= 0;
        output_done <= 0;
    end
    else begin
        case (state)
            // 状态0：空闲，等待启动信号
            S_IDLE: begin
                out_valid <= 0;
                output_done <= 0;
                output_busy <= 0;
                
                if (start_output) begin
                    state <= S_WAIT_FFT;
                    output_busy <= 1;
                    wait_counter <= 0;
                end
            end
        S_WAIT_FFT: begin
                if (wait_counter == 16'd40) begin  // 稍微多等一些，确保稳定
                    state <= S_OUTPUT_REAL;
                    out_counter <= 0;
                end
                else begin
                    wait_counter <= wait_counter + 1;
                end
            end
            
            // 状态2：输出32个实部
            S_OUTPUT_REAL: begin
                serial_out <= reg_array_r[out_counter[4:0]];  // 使用低5位作为数组索引
                out_valid <= 1;
                out_type <= 0;  // 实部
                
                if (out_counter[4:0] == 5'b11111) begin  // 已输出32个实部
                    state <= S_OUTPUT_IMAG;
                    out_counter <= 0;  // 重置为0，开始输出虚部
                end
                else begin
                    out_counter <= out_counter + 1;
                end
            end
            
            // 状态3：输出32个虚部
            S_OUTPUT_IMAG: begin
                serial_out <= reg_array_i[out_counter[4:0]];  // 使用低5位作为数组索引
                out_valid <= 1;
                out_type <= 1;  // 虚部
                
                if (out_counter[4:0] == 5'b11111) begin  // 已输出32个虚部
                    state <= S_DONE;
                    out_counter <= 0;
                end
                else begin
                    out_counter <= out_counter + 1;
                end
            end
            
            // 状态4：输出完成
            S_DONE: begin
                out_valid <= 0;
                output_done <= 1;
                output_busy <= 0;
                
                // 保持完成状态一个周期后返回空闲
                state <= S_IDLE;
            end
            
            default: begin
                state <= S_IDLE;
            end
        endcase
    end
end

endmodule