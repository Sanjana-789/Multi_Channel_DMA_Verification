    //--------------------------------------------------
    // FSM-based
    // Multi-channel (4 channels)
    // Fixed-priority arbitration
    // Transfer-size aware
    // Busy indication
    // Transfer counter
    // Reset handling
    //--------------------------------------------------
module dma_controller (

    input  logic        clk,
    input  logic        rst_n,

    input  logic [3:0]  req,

    input  logic [7:0]  transfer_size,

    output logic [3:0]  done,

    output logic        busy

);

    //--------------------------------------------------
    // FSM states
    //--------------------------------------------------

    typedef enum logic [2:0] {

        IDLE        = 3'd0,
        ARBITRATION = 3'd1,
        READ        = 3'd2,
        WRITE       = 3'd3,
        COMPLETE    = 3'd4

    } state_t;

    state_t current_state;
    state_t next_state;

    //--------------------------------------------------
    // Internal signals
    //--------------------------------------------------

    logic [1:0] selected_channel;

    logic [7:0] count;

    //--------------------------------------------------
    // State register
    //--------------------------------------------------

    always_ff @(posedge clk or negedge rst_n)
    begin

        if (!rst_n)
            current_state <= IDLE;

        else
            current_state <= next_state;

    end

    //--------------------------------------------------
    // Next-state logic
    //--------------------------------------------------

    always_comb
    begin

        next_state = current_state;

        case(current_state)

            IDLE:
            begin
                if(req != 4'b0000)
                    next_state = ARBITRATION;
            end

            ARBITRATION:
                next_state = READ;

            READ:
                next_state = WRITE;

            WRITE:
            begin

                if(count == transfer_size)
                    next_state = COMPLETE;

                else
                    next_state = READ;

            end

            COMPLETE:
                next_state = IDLE;

            default:
                next_state = IDLE;

        endcase

    end

    //--------------------------------------------------
    // Fixed-priority arbitration
    //--------------------------------------------------

    always_ff @(posedge clk or negedge rst_n)
    begin

        if(!rst_n)
            selected_channel <= 2'd0;

        else if(current_state == ARBITRATION)
        begin

            if(req[0])
                selected_channel <= 2'd0;

            else if(req[1])
                selected_channel <= 2'd1;

            else if(req[2])
                selected_channel <= 2'd2;

            else if(req[3])
                selected_channel <= 2'd3;

        end

    end

    //--------------------------------------------------
    // Transfer counter
    //--------------------------------------------------

    always_ff @(posedge clk or negedge rst_n)
    begin

        if(!rst_n)
            count <= 8'd0;

        else
        begin

            case(current_state)

                IDLE:
                    count <= 8'd0;

                WRITE:
                    count <= count + 1'b1;

                default:
                    count <= count;

            endcase

        end

    end

    //--------------------------------------------------
    // Busy generation
    //--------------------------------------------------

    always_comb
    begin

        if(current_state == IDLE)
            busy = 1'b0;
        else
            busy = 1'b1;

    end

    //--------------------------------------------------
    // Done generation
    //--------------------------------------------------

    always_ff @(posedge clk or negedge rst_n)
    begin

        if(!rst_n)
        begin

            done <= 4'b0000;

        end

        else
        begin

            done <= 4'b0000;

            if(current_state == COMPLETE)
            begin

                case(selected_channel)

                    2'd0: done[0] <= 1'b1;

                    2'd1: done[1] <= 1'b1;

                    2'd2: done[2] <= 1'b1;

                    2'd3: done[3] <= 1'b1;

                endcase

            end

        end

    end

endmodule
