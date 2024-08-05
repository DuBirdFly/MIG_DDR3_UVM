onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group mig /Top/u_wrapper_mig/sys_rst
add wave -noupdate -group mig /Top/u_wrapper_mig/aresetn
add wave -noupdate -group mig /Top/u_wrapper_mig/clk_ref_i
add wave -noupdate -group mig /Top/u_wrapper_mig/sys_clk_i
add wave -noupdate -group mig /Top/u_wrapper_mig/ui_clk_sync_rst
add wave -noupdate -group mig /Top/u_wrapper_mig/ui_clk
add wave -noupdate -group mig /Top/u_wrapper_mig/init_calib_complete
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/reset_n
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/dq
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/dqs_p
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/dqs_n
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/dm
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/cke
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/ck_p
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/ck_n
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/ba
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/addr
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/ras_n
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/cas_n
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/we_n
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/cs_n
add wave -noupdate -group ifMemDDR3 /Top/ifMemDDR3/odt
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/reset_n
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/dq
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/dqs_p
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/dqs_n
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/dm
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/cke
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/ck_p
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/ck_n
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/ba
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/addr
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/ras_n
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/cas_n
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/we_n
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/cs_n
add wave -noupdate -group ifMemFPGA /Top/ifMemFPGA/odt
add wave -noupdate -group ifAxi /Top/ifAxi/aclk
add wave -noupdate -group ifAxi /Top/ifAxi/aresetn
add wave -noupdate -group ifAxi -group aw /Top/ifAxi/awid
add wave -noupdate -group ifAxi -group aw /Top/ifAxi/awaddr
add wave -noupdate -group ifAxi -group aw /Top/ifAxi/awlen
add wave -noupdate -group ifAxi -group aw /Top/ifAxi/awsize
add wave -noupdate -group ifAxi -group aw /Top/ifAxi/awburst
add wave -noupdate -group ifAxi -group aw /Top/ifAxi/awvalid
add wave -noupdate -group ifAxi -group aw /Top/ifAxi/awready
add wave -noupdate -group ifAxi -group w /Top/ifAxi/wdata
add wave -noupdate -group ifAxi -group w /Top/ifAxi/wstrb
add wave -noupdate -group ifAxi -group w /Top/ifAxi/wlast
add wave -noupdate -group ifAxi -group w /Top/ifAxi/wvalid
add wave -noupdate -group ifAxi -group w /Top/ifAxi/wready
add wave -noupdate -group ifAxi -group b /Top/ifAxi/bid
add wave -noupdate -group ifAxi -group b /Top/ifAxi/bresp
add wave -noupdate -group ifAxi -group b /Top/ifAxi/bvalid
add wave -noupdate -group ifAxi -group b /Top/ifAxi/bready
add wave -noupdate -group ifAxi -group ar /Top/ifAxi/arid
add wave -noupdate -group ifAxi -group ar /Top/ifAxi/araddr
add wave -noupdate -group ifAxi -group ar /Top/ifAxi/arlen
add wave -noupdate -group ifAxi -group ar /Top/ifAxi/arsize
add wave -noupdate -group ifAxi -group ar /Top/ifAxi/arburst
add wave -noupdate -group ifAxi -group ar /Top/ifAxi/arvalid
add wave -noupdate -group ifAxi -group ar /Top/ifAxi/arready
add wave -noupdate -group ifAxi -group r /Top/ifAxi/rid
add wave -noupdate -group ifAxi -group r /Top/ifAxi/rresp
add wave -noupdate -group ifAxi -group r /Top/ifAxi/rdata
add wave -noupdate -group ifAxi -group r /Top/ifAxi/rlast
add wave -noupdate -group ifAxi -group r /Top/ifAxi/rvalid
add wave -noupdate -group ifAxi -group r /Top/ifAxi/rready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 fs} 0}
quietly wave cursor active 0
configure wave -namecolwidth 194
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {55632499050 fs} {55632500014 fs}
