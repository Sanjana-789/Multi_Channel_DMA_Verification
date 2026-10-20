module top;

    dma_if vif();

    test t;

    //------------------------------------------------
    // Clock Generation
    //------------------------------------------------

    initial begin

        vif.clk = 0;

        forever #5 vif.clk = ~vif.clk;

    end

    //------------------------------------------------
    // DUT
    //------------------------------------------------

    dma_controller dut (

        .clk(vif.clk),

        .rst_n(vif.rst_n),

        .req(vif.req),

        .transfer_size(vif.transfer_size),

        .done(vif.done),

        .busy(vif.busy)

    );

    //------------------------------------------------
    // Test
    //------------------------------------------------

    initial begin

        t = new(vif);

        t.run();

    end

endmodule