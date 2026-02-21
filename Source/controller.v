module controller #(
    parameter STATE_WIDTH = 6
)(
    input  wire clk,
    input  wire rst_in,
    input  wire start,
    input  wire done_rnd,
    input  wire i_is_all_one,

    output reg  rst_out,
    output reg  load_msg,
    output reg  start_rnd,
    output reg  inc,
    output reg  load_enable,
    output reg  done
);

    localparam IDLE      = 6'b000001;
    localparam LOAD_MEM  = 6'b000010;
    localparam F_LOGIC   = 6'b000100;
    localparam WAIT_RND  = 6'b001000;
    localparam UPDATE    = 6'b010000;
    localparam DONE_ST   = 6'b100000;

    reg [5:0] state, next_state;

    always @(posedge clk) begin
        if (rst_in)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE:      next_state = start     ? LOAD_MEM : IDLE;
            LOAD_MEM:  next_state = F_LOGIC;
            F_LOGIC:   next_state = WAIT_RND;
            WAIT_RND:  next_state = done_rnd  ? UPDATE   : WAIT_RND;
            UPDATE:    next_state = i_is_all_one      ? DONE_ST  : F_LOGIC;
            DONE_ST:   next_state = DONE_ST;
            default:   next_state = IDLE;
        endcase
    end

    always @(*) begin
        rst_out     = 1'b0;
        load_msg    = 1'b0;
        start_rnd   = 1'b0;
        inc         = 1'b0;
        load_enable = 1'b0;
        done        = 1'b0;

        case (state)
            IDLE: begin
                rst_out = 1'b1;
            end
            LOAD_MEM: begin
                load_msg = 1'b1;
            end
            F_LOGIC: begin
                start_rnd = 1'b1;
            end
            UPDATE: begin
                inc         = 1'b1;
                load_enable = 1'b1;
            end
            DONE_ST: begin
                done = 1'b1;
            end
        endcase
    end

endmodule
