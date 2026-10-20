class environment;

    generator  gen;
    driver     drv;
    monitor    mon;
    scoreboard scb;

    mailbox gen2drv;
    mailbox mon2scb;

    virtual dma_if vif;

    function new(virtual dma_if vif);

        this.vif = vif;

        gen2drv = new();
        mon2scb = new();

        gen = new(gen2drv);

        drv = new(vif, gen2drv);

        mon = new(vif, mon2scb);

        scb = new(mon2scb);

    endfunction

    task run();

        fork

            gen.run();

            drv.run();

            mon.run();

            scb.run();

        join_none

    endtask

endclass