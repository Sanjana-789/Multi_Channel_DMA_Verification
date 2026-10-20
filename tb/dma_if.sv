interface dma_if;

    logic clk;

    logic rst_n;

    logic [3:0] req;

    logic [7:0] transfer_size;

    logic [3:0] done;

    logic busy;

endinterface