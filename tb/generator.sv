class generator;

    mailbox gen2drv;

    function new(mailbox gen2drv);

        this.gen2drv = gen2drv;

    endfunction

    task run();

        dma_transaction tr;

        repeat(10)

        begin

            tr = new();

            assert(tr.randomize());

            gen2drv.put(tr);

            $display("[GEN] Generated req = %b", tr.req);

        end

    endtask

endclass