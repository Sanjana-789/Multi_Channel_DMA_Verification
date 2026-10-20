class scoreboard;

    mailbox mon2scb;

    int total_checks;
    int total_pass;
    int total_fail;

    function new(mailbox mon2scb);

        this.mon2scb = mon2scb;

    endfunction

    task run();

        dma_transaction tr;

        bit [3:0] expected_done;

        forever begin

            mon2scb.get(tr);

            expected_done = 4'b0000;

            //----------------------------------
            // Fixed Priority Prediction
            //----------------------------------

            if(tr.req[0])
                expected_done = 4'b0001;

            else if(tr.req[1])
                expected_done = 4'b0010;

            else if(tr.req[2])
                expected_done = 4'b0100;

            else if(tr.req[3])
                expected_done = 4'b1000;

            //----------------------------------
            // Compare only when DUT completes
            //----------------------------------

            if(tr.done != 4'b0000)
            begin

                total_checks++;

                if(tr.done == expected_done)
                begin

                    total_pass++;

                    $display(
                        "[PASS] exp=%b act=%b",
                        expected_done,
                        tr.done
                    );

                end
                else
                begin

                    total_fail++;

                    $display(
                        "[FAIL] exp=%b act=%b",
                        expected_done,
                        tr.done
                    );

                end

            end

        end

    endtask

    function void report();

        $display("\n================================");
        $display("SCOREBOARD REPORT");
        $display("================================");
        $display("Total Checks : %0d", total_checks);
        $display("Total Pass   : %0d", total_pass);
        $display("Total Fail   : %0d", total_fail);
        $display("================================\n");

    endfunction

endclass