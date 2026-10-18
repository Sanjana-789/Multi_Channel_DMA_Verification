interface dma_if;

    logic clk;
    logic rst_n;

    logic [3:0] req;
    logic [3:0] done;

endinterface