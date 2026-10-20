class generator;

    mailbox gen2drv;

    int num_transactions;

    function new(mailbox gen2drv);

        this.gen2drv = gen2drv;

        num_transactions = 50;

    endfunction

    task run();

        dma_transaction tr;

        repeat(num_transactions)
        begin

            tr = new();

            assert(tr.randomize())
            else
                $error("[GEN] Randomization Failed");

            gen2drv.put(tr);

            $display(
                "[GEN] req=%b size=%0d",
                tr.req,
                tr.transfer_size
            );

        end

        $display("[GEN] Generation Complete");

    endtask

endclass