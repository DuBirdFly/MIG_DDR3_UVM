class Test extends uvm_test;

    /* Factory Register this Class */
    `uvm_component_utils(Test)

    /* Declare Normal Variables */

    /* Declare Object Handles */
    virtual IfAxi vifAxi;
    Env env = Env::type_id::create("env", this);

    function new(string name = "Test", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        //! 不允许用 '_' 来进行分隔, 有 bug
        // uvm_top.set_timeout(60ms, 0);

        /* Override */

        /* uvm_config_db#(<type>)::get(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
        if (!uvm_config_db#(virtual IfAxi)::get(this, "", "vifAxi", vifAxi))
            `uvm_fatal("NOVIF", "No IfAxi Interface Specified")
        /* uvm_config_db#(<type>)::set(<uvm_component>, <"inst_name">, <"field_name">, <value>); */
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "start_of_simulation_phase: print_topology", UVM_MEDIUM)
        uvm_top.print_topology();
        `uvm_info(get_type_name(), "report_phase: print_factory", UVM_MEDIUM)
        factory.print();
    endfunction

    virtual task run_phase(uvm_phase phase);
        AxiMstrSeqWr axiMstrSeqWr = AxiMstrSeqWr::type_id::create("axiMstrSeqWr");
        AxiMstrSeqRd axiMstrSeqRd = AxiMstrSeqRd::type_id::create("axiMstrSeqRd");

        phase.raise_objection(this);

        wait(vifAxi.init_calib_complete == 1);
        $display("\n============================================");
        $display("    Init Calib Done (time: %t)    ", $time());
        $display("============================================\n");

        phase.drop_objection(this);
    endtask

endclass
