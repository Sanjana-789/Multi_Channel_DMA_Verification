class driver;

    virtual dma_if vif;

    mailbox gen2drv;

    function new(
        virtual dma_if vif,
        mailbox gen2drv
    );

        this.vif = vif;
        this.gen2drv = gen2drv;

    endfunction

    task run();

        dma_transaction tr;

        forever
        begin

            gen2drv.get(tr);

            @(posedge vif.clk);

            vif.req <= tr.req;

            $display("[DRV] Driving req = %b", tr.req);

        end

    endtask

endclass