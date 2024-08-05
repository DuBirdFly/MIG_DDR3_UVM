module wrapper_ddr3(
    IfMem        ifMem
);

    initial begin
        #1;
        if (`MEM_DQ_WIDTH % 16 != 0) begin
            $display("TEST FAILED: DQ_WIDTH must be a multiple of 16");
            $finish;            
        end
    end

    ddr3_model u0_comp_ddr3 (
        .rst_n      ( ifMem.reset_n         ),

        .dq         ( ifMem.dq[15:0]        ),
        .dqs        ( ifMem.dqs_p[1:0]      ),
        .dqs_n      ( ifMem.dqs_n[1:0]      ),
        .tdqs_n     (                       ),
        .dm_tdqs    ( ifMem.dm[1:0]         ),

        .cke        ( ifMem.cke             ),
        .ck         ( ifMem.ck_p            ),
        .ck_n       ( ifMem.ck_n            ),

        .ba         ( ifMem.ba              ),
        .addr       ( ifMem.addr            ),
        .ras_n      ( ifMem.ras_n           ),
        .cas_n      ( ifMem.cas_n           ),
        .we_n       ( ifMem.we_n            ),

        .cs_n       ( ifMem.cs_n            ),
        .odt        ( ifMem.odt             )
    );

    ddr3_model u1_comp_ddr3 (
        .rst_n      ( ifMem.reset_n         ),

        .dq         ( ifMem.dq[31:16]       ),
        .dqs        ( ifMem.dqs_p[3:2]      ),
        .dqs_n      ( ifMem.dqs_n[3:2]      ),
        .tdqs_n     (                       ),
        .dm_tdqs    ( ifMem.dm[3:2]         ),

        .cke        ( ifMem.cke             ),
        .ck         ( ifMem.ck_p            ),
        .ck_n       ( ifMem.ck_n            ),

        .ba         ( ifMem.ba              ),
        .addr       ( ifMem.addr            ),
        .ras_n      ( ifMem.ras_n           ),
        .cas_n      ( ifMem.cas_n           ),
        .we_n       ( ifMem.we_n            ),

        .cs_n       ( ifMem.cs_n            ),
        .odt        ( ifMem.odt             )
    );

endmodule
