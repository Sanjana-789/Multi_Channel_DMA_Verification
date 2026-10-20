class dma_transaction;

    rand bit [3:0] req;

    rand bit [7:0] transfer_size;

    bit [3:0] done;

    bit busy;

    constraint valid_req_c
    {
        req != 4'b0000;
    }

    constraint size_c
    {
        transfer_size inside {[1:20]};
    }

endclass