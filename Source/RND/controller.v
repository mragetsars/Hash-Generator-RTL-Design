module RND_controller (
    input  wire clk,
    input  wire rst,
    input  wire start_rnd,
    input  wire co_co,
    output reg  x_en,
    output reg  x_init,
    output reg  co_en,
    output reg  co_init,
    output reg  done_rnd
);

    localparam IDLE = 2'b00,
               INIT = 2'b01,
               RUN  = 2'b10;

    reg [1:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: if (start_rnd) next_state = INIT;
            INIT:                next_state = RUN;
            RUN:  if (co_co)     next_state = IDLE;
        endcase
    end

    always @(*) begin
        x_en       = 0;
        x_init     = 0;
        co_en      = 0;
        co_init    = 0;
        done_rnd   = 0;
        case (state)
            IDLE: begin
                done_rnd   = 1;
            end

            INIT: begin
                x_init     = 1;
                co_init    = 1;
            end

            RUN: begin
                x_en       = 1;
                co_en      = 1;
            end
        endcase
    end

endmodule

