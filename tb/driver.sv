class driver;

    virtual dma_if vif;

    mailbox gen2drv;

    function new(
        virtual dma_if vif,
        mailbox gen2drv
    );

        this.vif     = vif;
        this.gen2drv = gen2drv;

    endfunction

    task run();

        dma_transaction tr;

        forever
        begin

            gen2drv.get(tr);

            //----------------------------------
            // Wait until DMA is free
            //----------------------------------

            wait(vif.busy == 0);

            @(posedge vif.clk);

            vif.req <= tr.req;

            vif.transfer_size <= tr.transfer_size;

            $display(
                "[DRV] req=%b size=%0d",
                tr.req,
                tr.transfer_size
            );

            //----------------------------------
            // Hold request for one cycle
            //----------------------------------

            @(posedge vif.clk);

            vif.req <= 4'b0000;

        end

    endtask

endclass