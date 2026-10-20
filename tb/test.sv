class test;

    environment env;

    virtual dma_if vif;

    function new(virtual dma_if vif);

        this.vif = vif;

        env = new(vif);

    endfunction

    task reset();

        vif.rst_n <= 0;

        vif.req <= 0;

        vif.transfer_size <= 0;

        repeat(5)
            @(posedge vif.clk);

        vif.rst_n <= 1;

        $display("[TEST] Reset Completed");

    endtask

    task run();

        reset();

        env.run();

        repeat(200)
            @(posedge vif.clk);

        env.scb.report();

        $finish;

    endtask

endclass