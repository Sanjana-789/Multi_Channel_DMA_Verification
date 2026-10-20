class monitor;

    virtual dma_if vif;

    mailbox mon2scb;

    function new(
        virtual dma_if vif,
        mailbox mon2scb
    );
        this.vif     = vif;
        this.mon2scb = mon2scb;
    endfunction

    task run();

        dma_transaction tr;

        forever begin

            @(posedge vif.clk);

            tr = new();

            tr.req            = vif.req;
            tr.transfer_size  = vif.transfer_size;
            tr.done           = vif.done;
            tr.busy           = vif.busy;

            mon2scb.put(tr);

            $display(
                "[MON] time=%0t req=%b done=%b busy=%b size=%0d",
                $time,
                tr.req,
                tr.done,
                tr.busy,
                tr.transfer_size
            );

        end

    endtask

endclass