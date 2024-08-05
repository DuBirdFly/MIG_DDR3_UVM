module wrapper_mig(
    IfMem                   ifMem,
    IfAxi                   ifAxi,

    input                   sys_rst,
    input                   aresetn,
    input                   sys_clk_i,
    input                   clk_ref_i,

    output                  ui_clk,
    output                  ui_clk_sync_rst,
    output                  init_calib_complete
);

    mig u_mig(
        ///////////////////////////////////////////////
        .ddr3_reset_n                   ( ifMem.reset_n ),

        .ddr3_dq                        ( ifMem.dq      ), // 32-bit
        .ddr3_dqs_p                     ( ifMem.dqs_p   ), // 4-bit
        .ddr3_dqs_n                     ( ifMem.dqs_n   ), // 4-bit
        .ddr3_dm                        ( ifMem.dm      ), // 4-bit

        .ddr3_cke                       ( ifMem.cke     ),
        .ddr3_ck_p                      ( ifMem.ck_p    ),
        .ddr3_ck_n                      ( ifMem.ck_n    ),

        .ddr3_ba                        ( ifMem.ba      ), // 3-bit
        .ddr3_addr                      ( ifMem.addr    ), // 13-bit
        .ddr3_ras_n                     ( ifMem.ras_n   ),
        .ddr3_cas_n                     ( ifMem.cas_n   ),
        .ddr3_we_n                      ( ifMem.we_n    ),

        .ddr3_cs_n                      ( ifMem.cs_n    ),
        .ddr3_odt                       ( ifMem.odt     ),
        ///////////////////////////////////////////////
        .s_axi_awid                     ( ifAxi.awid    ),
        .s_axi_awaddr                   ( ifAxi.awaddr  ),
        .s_axi_awlen                    ( ifAxi.awlen   ),
        .s_axi_awsize                   ( ifAxi.awsize  ),
        .s_axi_awburst                  ( ifAxi.awburst ),
        .s_axi_awlock                   ( '0            ),
        .s_axi_awcache                  ( '0            ),
        .s_axi_awprot                   ( '0            ),
        .s_axi_awqos                    ( '0            ),
        .s_axi_awvalid                  ( ifAxi.awvalid ),
        .s_axi_awready                  ( ifAxi.awready ),
        ///////////////////////////////////////////////
        .s_axi_wdata                    ( ifAxi.wdata   ),
        .s_axi_wstrb                    ( ifAxi.wstrb   ),
        .s_axi_wlast                    ( ifAxi.wlast   ),
        .s_axi_wvalid                   ( ifAxi.wvalid  ),
        .s_axi_wready                   ( ifAxi.wready  ),
        ///////////////////////////////////////////////
        .s_axi_bid                      ( ifAxi.bid     ),
        .s_axi_bresp                    ( ifAxi.bresp   ),
        .s_axi_bvalid                   ( ifAxi.bvalid  ),
        .s_axi_bready                   ( ifAxi.bready  ),
        ///////////////////////////////////////////////
        .s_axi_arid                     ( ifAxi.arid    ),
        .s_axi_araddr                   ( ifAxi.araddr  ),
        .s_axi_arlen                    ( ifAxi.arlen   ),
        .s_axi_arsize                   ( ifAxi.arsize  ),
        .s_axi_arburst                  ( ifAxi.arburst ),
        .s_axi_arlock                   ( '0            ),
        .s_axi_arcache                  ( '0            ),
        .s_axi_arprot                   ( '0            ),
        .s_axi_arqos                    ( '0            ),
        .s_axi_arvalid                  ( ifAxi.arvalid ),
        .s_axi_arready                  ( ifAxi.arready ),
        ///////////////////////////////////////////////
        .s_axi_rid                      ( ifAxi.rid     ),
        .s_axi_rdata                    ( ifAxi.rdata   ),
        .s_axi_rresp                    ( ifAxi.rresp   ),
        .s_axi_rlast                    ( ifAxi.rlast   ),
        .s_axi_rvalid                   ( ifAxi.rvalid  ),
        .s_axi_rready                   ( ifAxi.rready  ),
        ///////////////////////////////////////////////
        .sys_rst                        ( sys_rst       ),
        .aresetn                        ( aresetn       ),
        .sys_clk_i                      ( sys_clk_i     ),
        .clk_ref_i                      ( clk_ref_i     ),
        ///////////////////////////////////////////////
        .ui_clk                         ( ui_clk            ), // output, axi_clk
        .ui_clk_sync_rst                ( ui_clk_sync_rst   ), // output, axi_rst
        .mmcm_locked                    (                   ), // output
    
        .app_sr_req                     ( 1'b0              ), // input
        .app_ref_req                    ( 1'b0              ), // input
        .app_zq_req                     ( 1'b0              ), // input
        .app_sr_active                  (                   ), // output
        .app_ref_ack                    (                   ), // output
        .app_zq_ack                     (                   ), // output

        .init_calib_complete            ( init_calib_complete ), // output
        .device_temp                    (                   )  // output
    );

endmodule
