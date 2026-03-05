-q                  // 安静模式
+v2k                // 支持 Verilog-2001 语法
-sverilog           // 支持 SystemVerilog
-debug_access+all   // 支持调试 (all: 写(+w), 读(+r), force(+f), ucli单步调试(+l), 网表操作(+n) ......)
-kdb                // 生成 verdi 需要的 database
-timescale=1ns/1ps  // 设置初始的默认仿真时间单位
-Mupdate            // 增量编译


// -top top            // 指定顶层模块
// -notice             // 更详细的 log 信息
// -diag timescale     // 打印 module timescale 以及其来源
// -j8                 // 多线程并行编译 (8指的是8个线程)
// +vcs+fsdbon         // 编译时替代 $fsdbDumpvars 选项
// -R                  // 编译完成后直接运行可执行文件 (如 simv)
// +error+1000         // 指定最大的 NTB errors
// +lint=all           // 打开所有的 lint 选项
// +warn=noCDNYI,noIPDW,noILLGO,noTMR,noPHNE,noIRIID-W // 关闭指定的警告
// +vpi                // 允许使用 VPI PLI 访问
// +plusarg_save       // 允许在编译期就记录 plusarg
// +vcs+flush+all      // 更快的 log, vcd, fopen 的 flush 速度
// -simprofile         // 生成 profile 文件

// ========================================================
// No Warn Options
// +warn=noCDNYI
// +warn=noIPDW
// +warn=noILLGO
// +warn=noTMR
// +warn=noPHNE
// +warn=noIRIID-W
