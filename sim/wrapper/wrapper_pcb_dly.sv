module wrapper_pcb_dly(
    IfMem ifMemFPGA,
    IfMem ifMemDDR3,
    input sys_rst_n,
    input init_calib_complete
);

    localparam real TPROP_PCB_CTRL     = 0.00;
    localparam real TPROP_DQS_WR       = 0.00;
    localparam real TPROP_DQS_RD       = 0.00;
    localparam real TPROP_PCB_DATA_WR  = 0.00;
    localparam real TPROP_PCB_DATA_RD  = 0.00;

    reg                         tmp_cs_n;
    reg                         tmp_odt;
    reg   [`MEM_DM_WIDTH-1:0]   tmp_dm;

    always @(*) begin
        ifMemDDR3.cke       <=  #(TPROP_PCB_CTRL) ifMemFPGA.cke;
        ifMemDDR3.ck_p      <=  #(TPROP_PCB_CTRL) ifMemFPGA.ck_p;
        ifMemDDR3.ck_n      <=  #(TPROP_PCB_CTRL) ifMemFPGA.ck_n;

        ifMemDDR3.ba        <=  #(TPROP_PCB_CTRL) ifMemFPGA.ba;
        ifMemDDR3.addr      <=  #(TPROP_PCB_CTRL) ifMemFPGA.addr;
        ifMemDDR3.ras_n     <=  #(TPROP_PCB_CTRL) ifMemFPGA.ras_n;
        ifMemDDR3.cas_n     <=  #(TPROP_PCB_CTRL) ifMemFPGA.cas_n;
        ifMemDDR3.we_n      <=  #(TPROP_PCB_CTRL) ifMemFPGA.we_n;
    end

    always @(*) tmp_cs_n <=  #(TPROP_PCB_CTRL) ifMemFPGA.cs_n;
    assign ifMemDDR3.cs_n = tmp_cs_n;

    always @(*) tmp_odt  <=  #(TPROP_PCB_CTRL) ifMemFPGA.odt;
    assign ifMemDDR3.odt = tmp_odt;

    always @(*) tmp_dm   <=  #(TPROP_PCB_DATA_WR) ifMemFPGA.dm;
    assign ifMemDDR3.dm = tmp_dm;

    genvar dqwd;
    generate
        for (dqwd = 0; dqwd < `MEM_DQ_WIDTH; dqwd++) begin: gen_dq
            WireDelay # (
                .Delay_g    (TPROP_PCB_DATA_WR),
                .Delay_rd   (TPROP_PCB_DATA_RD),
                .ERR_INSERT ("OFF")
            ) u_delay_dq (
                .A             (ifMemFPGA.dq[dqwd]),
                .B             (ifMemDDR3.dq[dqwd]),
                .reset_n       (sys_rst_n),
                .phy_init_done (init_calib_complete)
            );
        end
    endgenerate

    genvar dqspwd;
    generate
        for (dqspwd = 0; dqspwd < `MEM_DQS_WIDTH; dqspwd++) begin: gen_dqs_p
            WireDelay # (
                .Delay_g    (TPROP_DQS_WR),
                .Delay_rd   (TPROP_DQS_RD),
                .ERR_INSERT ("OFF")
            ) u_delay_dqs_p (
                .A             (ifMemFPGA.dqs_p[dqspwd]),
                .B             (ifMemDDR3.dqs_p[dqspwd]),
                .reset_n       (sys_rst_n),
                .phy_init_done (init_calib_complete)
            );
        end
    endgenerate

    genvar dqsnwd;
    generate
        for (dqsnwd = 0; dqsnwd < `MEM_DQS_WIDTH; dqsnwd++) begin: gen_dqs_n
            WireDelay # (
                .Delay_g    (TPROP_DQS_WR),
                .Delay_rd   (TPROP_DQS_RD),
                .ERR_INSERT ("OFF")
            ) u_delay_dqs_n (
                .A             (ifMemFPGA.dqs_n[dqsnwd]),
                .B             (ifMemDDR3.dqs_n[dqsnwd]),
                .reset_n       (sys_rst_n),
                .phy_init_done (init_calib_complete)
            );
        end
    endgenerate

endmodule