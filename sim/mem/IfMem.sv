interface IfMem;

    logic                           reset_n;

    wire  [`MEM_DQ_WIDTH-1:0]       dq;     // inout  [31:0]  <--> inout [31:16] [15:0]
    wire  [`MEM_DQS_WIDTH-1:0]      dqs_p;  // inout  [ 4:0]  <--> inout [ 3: 2] [ 1:0]
    wire  [`MEM_DQS_WIDTH-1:0]      dqs_n;  // inout  [ 4:0]  <--> inout [ 3: 2] [ 1:0]
    wire  [`MEM_DM_WIDTH-1:0]       dm;     // output [ 4:0]  <--> inout [ 3: 2] [ 1:0]

    logic                           cke;
    logic                           ck_p;
    logic                           ck_n;

    logic [`MEM_BA_WIDTH-1:0]       ba;
    logic [`MEM_ROW_WIDTH-1:0]      addr;
    logic                           ras_n;
    logic                           cas_n;
    logic                           we_n;

    logic                           cs_n;
    logic                           odt;

endinterface
