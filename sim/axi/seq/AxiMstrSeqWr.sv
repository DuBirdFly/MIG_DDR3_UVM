`define AxiMstrSeqWrSend(TR) \
    tr_q_aw.push_back(TR); tr_q_w.push_back(TR); \
    fork \
        begin \
            `zpf_do_on_clone(tr_q_aw[0], tr_aw, p_sequencer.axiMstrSqrAw) \
            tr_q_aw.delete(0); \
        end \
        begin \
            `zpf_do_on_clone(tr_q_w[0], tr_w, p_sequencer.axiMstrSqrW) \
            tr_q_w.delete(0); \
        end \
    join_any


class AxiMstrSeqWr extends uvm_sequence #(TrAxi);

    /* Factory Register this Class */
    `uvm_object_utils(AxiMstrSeqWr)
    `uvm_declare_p_sequencer(AxiMstrVirSqrWr)

    /* Declare Normal Variables */

    /* Declare Object Handles */

    function new(string name = "AxiMstrSeqWr");
        super.new(name);
    endfunction

    virtual task body();
        if (starting_phase != null) starting_phase.raise_objection(this);
        // case_init(1);
        case_0_run(256);
        // case_1_run(1);
        if (starting_phase != null) starting_phase.drop_objection(this);
    endtask

    // 初始化前 (4096 * tr_num) (Byte) 的数据
    virtual task case_init(int tr_num);
        TrAxi tr_q_aw[$], tr_q_w[$], tr_aw, tr_w;

        for (int i = 0; i < tr_num; i++) begin
            TrAxi tr = TrAxi::type_id::create("tr");
            tr.wr_flag = 1;

            // 不能跨 4K 边界, 128 * (2 ^ 5) = 4K
            `zpf_randomize_with(tr, {addr == i * 'h1000; len == 127; size == 5; burst == 1;})
            for (int i = 0; i < tr.len + 1; i++) tr.data[i]  = '0;
            for (int i = 0; i < tr.len + 1; i++) tr.wstrb[i] = '1;

            tr.align_calcu();

            `AxiMstrSeqWrSend(tr)
        end

    endtask

    // 发送随机的 INCR 写
    virtual task case_0_run(int tr_num);
        TrAxi tr_q_aw[$], tr_q_w[$], tr_aw, tr_w;

        repeat (tr_num) begin
            //! tr 的开辟空间必须放在循环内，否则每次对象空间都会被销毁
            //  从而导致后续的 tr_q_aw 和 tr_q_w 句柄重复指向最后一个对象空间
            TrAxi tr = TrAxi::type_id::create("tr");
            tr.wr_flag = 1;

            `zpf_randomize_with(tr, {addr < 2048; len < 4; size == `AXI_SIZE_MAX; burst == 1;})

            for (int i = 0; i < tr.len; i++) tr.wstrb[i] = {`AXI_WSTRB_WIDTH{1'b1}};

            tr.align_calcu();

            `AxiMstrSeqWrSend(tr)
        end

        // 把没发完的发完
        wait (tr_q_aw.size() == 0 && tr_q_w.size() == 0);

    endtask

    virtual task case_1_run(int tr_num);
        TrAxi tr_q_aw[$], tr_q_w[$], tr_aw, tr_w;

        TrAxi tr = TrAxi::type_id::create("tr");
        tr.wr_flag = 1;

        `zpf_randomize_with(tr, {addr == 'h100; len == 0; size == 5; burst == 1;})

        tr.align_calcu();

        `AxiMstrSeqWrSend(tr)

    endtask

endclass
