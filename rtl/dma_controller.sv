module dma_controller (

    input  logic       clk,
    input  logic       rst_n,

    input  logic [3:0] req,

    output logic [3:0] done

);

logic [1:0] current_channel;

always_ff @(posedge clk or negedge rst_n)
begin

    if(!rst_n)
    begin
        current_channel <= 2'b00;
        done <= 4'b0000;
    end

    else
    begin

        done <= 4'b0000;

        if(req[0])
        begin
            current_channel <= 2'd0;
            done[0] <= 1'b1;
        end

        else if(req[1])
        begin
            current_channel <= 2'd1;
            done[1] <= 1'b1;
        end

        else if(req[2])
        begin
            current_channel <= 2'd2;
            done[2] <= 1'b1;
        end

        else if(req[3])
        begin
            current_channel <= 2'd3;
            done[3] <= 1'b1;
        end

    end

end

endmodule