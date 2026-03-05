// +UVM_NO_RELNOTES

+UVM_VERBOSITY+UVM_MEDIUM
// +UVM_VERBOSITY+UVM_DEBUG
// +UVM_VERBOSITY+UVM_LOW

// 关于 delta_cycle: https://bbs.eetop.cn/thread-916396-1-1.html
+fsdb+delta

// 将 constraint 失败从 warning 升级为 fatae
+ntb_stop_on_constraint_solver_error=1

// 开启仿真时间占用分析
// -simprofile time+json_dbg_field
