//! 极其不建议用 include 的方式引入文件
//! 因为用了 `timescale, 会导致导入该文件的文件 timescale 被覆盖

`timescale 1ns / 1ps

module WireDelay # (
    parameter Delay_g = 0,
    parameter Delay_rd = 0,
    parameter ERR_INSERT = "OFF"
)(
    inout A,
    inout B,
    input reset_n,
    input phy_init_done
);

    reg A_r, B_r;

    reg B_inv ;
    reg line_en;
    reg B_nonX;

    assign A = A_r;
    assign B = B_r;

    always @ (*) begin
        if (B === 1'bx)
            B_nonX <= $random;
        else
            B_nonX <= B;
    end

    always@(*) begin
        if((B_nonX == 'b1) || (B_nonX == 'b0))
            B_inv <= #0 ~B_nonX ;
        else
            B_inv <= #0 'bz ;
    end

    always @(*) begin
        if (!reset_n) begin
            A_r <= 1'bz;
            B_r <= 1'bz;
            line_en <= 1'b0;
        end
        else begin
            if (line_en) begin
                B_r <= 1'bz;
                if ((ERR_INSERT == "ON") & (phy_init_done))
                    A_r <= #Delay_rd B_inv;
                else
                    A_r <= #Delay_rd B_nonX;
            end
            else begin
                B_r <= #Delay_g A;
                A_r <= 1'bz;
            end
        end
    end

    always @(A or B) begin
        if (!reset_n) begin
            line_en <= 1'b0;
        end else if (A !== A_r) begin
            line_en <= 1'b0;
        end else if (B_r !== B) begin
            line_en <= 1'b1;
        end else begin
            line_en <= line_en;
        end
    end

endmodule
