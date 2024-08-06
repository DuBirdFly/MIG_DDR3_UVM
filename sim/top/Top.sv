import uvm_pkg::*;
`include "uvm_macros.svh"

`timescale 1ps/100fs

// mem
`include "mem_constants.svh"
`include "IfMem.sv"

// wrapper
`include "wrapper_mig.sv"
`include "wrapper_pcb_dly.sv"
`include "wrapper_ddr3.sv"

// zpf_uvm_wrapper
`include "zpf_defines.svh"

// axi_vip
`include "axi_includes.svh"

// Top_env
`include "Env.sv"

// test_top
`include "Test.sv"

module Top;
    //**************************************************************************//
    localparam RESET_PERIOD = 200000;
    reg  sys_rst_n = 1'b0;
    initial #RESET_PERIOD sys_rst_n = 1'b1;

    localparam SYS_CLK_PERIOD          = 5000;
    localparam REF_CLK_PERIOD          = 5000;

    reg                                 sys_clk_i = 1'b0;
    reg                                 clk_ref_i = 1'b0;

    always sys_clk_i = #(SYS_CLK_PERIOD / 2) ~sys_clk_i;
    always clk_ref_i = #(REF_CLK_PERIOD / 2) ~clk_ref_i;

    //**************************************************************************//
    wire    ui_clk;
    wire    ui_clk_sync_rst;
    wire    init_calib_complete;

    IfMem   ifMemFPGA();
    IfMem   ifMemDDR3();


    //* AXI Parameters ***********************************
    //   Data Width           : 256
    //   Arbitration Scheme   : RD_PRI_REG
    //   Narrow Burst Support : 1
    //   ID Width             : 4
    //****************************************************
    IfAxi   ifAxi(
        .aclk       ( ui_clk            ),
        .aresetn    ( ~ui_clk_sync_rst  ),
        .init_calib_complete    (init_calib_complete)
    );

    //* FPGA Options *************************************
    //   System Clock Type             : No Buffer
    //   Reference Clock Type          : No Buffer
    //   Debug Port                    : OFF
    //   Internal Vref                 : disabled
    //   IO Power Reduction            : ON
    //   XADC instantiation in MIG     : Enabled
    //* Controller Options *******************************
    //   Design Clock Frequency        : 1250 ps (800.00 MHz)
    //   Phy to Controller Clock Ratio : 4:1
    //   Input Clock Period            : 4999 ps
    //   CLKFBOUT_MULT (PLL)           : 8
    //   DIVCLK_DIVIDE (PLL)           : 1
    //   VCC_AUX IO                    : 2.0V
    //****************************************************
    wrapper_mig u_wrapper_mig(
        .ifMem                  ( ifMemFPGA             ), // 1.25 ns = 800MHz (double data rate: 1600MHz)
        .ifAxi                  ( ifAxi.SLAVE           ),

        .sys_rst                ( ~sys_rst_n            ), // input
        .aresetn                ( sys_rst_n             ), // input
        .sys_clk_i              ( sys_clk_i             ), // input, 5ns = 200MHz
        .clk_ref_i              ( clk_ref_i             ), // input, 5ns = 200MHz

        .ui_clk                 ( ui_clk                ), // output, 200MHz
        .ui_clk_sync_rst        ( ui_clk_sync_rst       ), // output
        .init_calib_complete    ( init_calib_complete   )  // output
    );

    wrapper_pcb_dly u_wrapper_pcb_dly(
        .ifMemFPGA              ( ifMemFPGA            ),
        .ifMemDDR3              ( ifMemDDR3            ),

        .sys_rst_n              ( sys_rst_n            ),
        .init_calib_complete    ( init_calib_complete  )
    );

    //* Memory Type **************************************
    //   Memory Type : Components
    //   Memory Part : MT41J64M16XX-125G
    //   Data Width  : 32
    //   ECC         : Disabled
    //   Data Mask   : enabled
    //   ORDERING    : Normal
    //* Memory Options ***********************************
    //   Burst Length (MR0[1:0])          : 8 - Fixed
    //   Read Burst Type (MR0[3])         : Sequential
    //   CAS Latency (MR0[6:4])           : 11
    //   Output Drive Strength (MR1[5,1]) : RZQ/7
    //   Controller CS option             : Enable
    //   Rtt_NOM - ODT (MR1[9,6,2])       : RZQ/4
    //   Rtt_WR - Dynamic ODT (MR2[10:9]) : Dynamic ODT off
    //   Memory Address Mapping           : BANK_ROW_COLUMN
    //****************************************************
    wrapper_ddr3 u_wrapper_ddr3(
        .ifMem                  ( ifMemDDR3            )
    );

    //* UVM Environment **********************************
    initial begin: uvm_config_db_interface
        uvm_config_db#(virtual IfAxi)::set(null, "uvm_test_top", "vifAxi", ifAxi);
        uvm_config_db#(virtual IfAxi)::set(null, "uvm_test_top.env.axiMstrEnv.axiMstrAgtWr.axiMstrChnAw", "vifAxi", ifAxi);
        uvm_config_db#(virtual IfAxi)::set(null, "uvm_test_top.env.axiMstrEnv.axiMstrAgtWr.axiMstrChnW",  "vifAxi", ifAxi);
        uvm_config_db#(virtual IfAxi)::set(null, "uvm_test_top.env.axiMstrEnv.axiMstrAgtWr.axiMstrChnB",  "vifAxi", ifAxi);
        uvm_config_db#(virtual IfAxi)::set(null, "uvm_test_top.env.axiMstrEnv.axiMstrAgtRd.axiMstrChnAr", "vifAxi", ifAxi);
        uvm_config_db#(virtual IfAxi)::set(null, "uvm_test_top.env.axiMstrEnv.axiMstrAgtRd.axiMstrChnR",  "vifAxi", ifAxi);
        uvm_config_db#(virtual IfAxi)::set(null, "uvm_test_top.env.axiMstrEnv.axiMstrAgtRd.axiMstrMonR",  "vifAxi", ifAxi);
    end

    initial begin: out_of_init_calib_time
        #200ms; // 大概在 55.6 ms 时初始化完成
        if (init_calib_complete != 1)
            $display("TEST FAILED: INITIALIZATION DID NOT COMPLETE");
        $finish;
    end

    initial begin
        $timeformat(-9, 3, "ns", 12);
        run_test("Test");
    end

endmodule
