module top_module #(
    parameter integer WIDTH = 128,
    // make WORD a parameter so it can be used in the port list
    parameter integer WORD  = WIDTH / 4,
    parameter MEM_PATH = "./constant.mem"
)(
    input  wire                   clk,
    input  wire                   rst,
    input  wire                   start,
    input  wire [WIDTH-1:0]       in_put,
    output wire                   done,
    output wire [WIDTH-1:0]        out_put
);

    // Sanity check (portable)
    initial begin
        if (WIDTH % 4 != 0) begin
            $display("ERROR: Parameter WIDTH (%0d) must be a multiple of 4.", WIDTH);
            $finish;
        end
    end

    // ------------------------------------------------------------
    // Internal signals
    // ------------------------------------------------------------
    wire load_msg, start_rnd, done_rnd, inc, load_enable, i_is_all_one;
    wire rst_ctrl;

    wire [WORD-1:0] M1, M2, M3, M4;
    wire [WORD-1:0] mux_out;
    wire [WORD-1:0] const_word;
    wire [1:0]       rnd_sel;
    wire [WORD-1:0]  F_logic, F_sum, rotF, B_plus_rotF;
    wire [5:0]       i_out;

    wire [WORD-1:0] A_reg, B_reg, C_reg, D_reg;

    // ------------------------------------------------------------
    // Controller
    // ------------------------------------------------------------
    controller #(.STATE_WIDTH(6)) u_ctrl (
        .clk(clk),
        .rst_in(rst),
        .start(start),
        .done_rnd(done_rnd),
        .i_is_all_one(i_is_all_one),

        .rst_out(rst_ctrl),
        .load_msg(load_msg),
        .start_rnd(start_rnd),
        .inc(inc),
        .load_enable(load_enable),
        .done(done)
    );

    // ------------------------------------------------------------
    // Message memory
    // ------------------------------------------------------------
    M_mem #(.WIDTH(WIDTH)) u_mmem (
        .clk(clk),
        .load_msg(load_msg),
        .msg_in(in_put),
        .M_out_1(M1),
        .M_out_2(M2),
        .M_out_3(M3),
        .M_out_4(M4)
    );

    // ------------------------------------------------------------
    // Constant memory
    // ------------------------------------------------------------
    const_mem #(.ADDR_WIDTH(6), .PATH(MEM_PATH)) u_const (
        .i_addr(i_out),
        .data(const_word)
    );

    // ------------------------------------------------------------
    // Round generator
    // ------------------------------------------------------------
    RND_top_module #(.REG_WIDTH(6), .CNT_WIDTH(3)) u_rnd (
        .clk(clk),
        .rst(rst_ctrl),
        .start_rnd(start_rnd),
        .seed(i_out),
        .done_rnd(done_rnd),
        .x_out(rnd_sel)
    );

    // ------------------------------------------------------------
    // MUX and function logic
    // ------------------------------------------------------------
    mux #(.WIDTH(WORD)) u_mux (
        .in1(M1),
        .in2(M2),
        .in3(M3),
        .in4(M4),
        .sel(rnd_sel),
        .out(mux_out)
    );

    F_logic_ALU #(.WIDTH(WORD)) u_flogic (
        .B(B_reg),
        .C(C_reg),
        .D(D_reg),
        .func_sel(i_out[5:4]),
        .F_logic(F_logic)
    );

    F_adder #(.WIDTH(WORD)) u_fadder (
        .F_logic(F_logic),
        .A(A_reg),
        .const_word(const_word),
        .m_word(mux_out),
        .F_sum(F_sum)
    );

    left_rotate_with_step #(.WIDTH(WORD)) u_rot (
        .val_in(F_sum),
        .i_in(i_out),
        .rotF(rotF)
    );

    B_adder #(.WIDTH(WORD)) u_badder (
        .B_old(B_reg),
        .rotF(rotF),
        .B_plus_rotF(B_plus_rotF)
    );

    // ------------------------------------------------------------
    // Register pipeline (module renamed to pipeline_reg)
    // ------------------------------------------------------------
    pipeline_reg #(.WIDTH(WORD), .INIT(32'h67452301)) u_regA (
        .d_in(D_reg),
        .load_enable(load_enable),
        .rst(rst_ctrl),
        .clk(clk),
        .q_out(A_reg)
    );

    pipeline_reg #(.WIDTH(WORD), .INIT(32'hefcdab89)) u_regB (
        .d_in(B_plus_rotF),
        .load_enable(load_enable),
        .rst(rst_ctrl),
        .clk(clk),
        .q_out(B_reg)
    );

    pipeline_reg #(.WIDTH(WORD), .INIT(32'h98badcfe)) u_regC (
        .d_in(B_reg),
        .load_enable(load_enable),
        .rst(rst_ctrl),
        .clk(clk),
        .q_out(C_reg)
    );

    pipeline_reg #(.WIDTH(WORD), .INIT(32'h10325476)) u_regD (
        .d_in(C_reg),
        .load_enable(load_enable),
        .rst(rst_ctrl),
        .clk(clk),
        .q_out(D_reg)
    );

    // ------------------------------------------------------------
    // Counter
    // ------------------------------------------------------------
    i_cnt #(.WIDTH(6)) u_cnt (
        .clk(clk),
        .rst(rst_ctrl),
        .inc(inc),
        .i_out(i_out),
        .i_is_all_one(i_is_all_one)
    );

    // ------------------------------------------------------------
    // Final result combiner
    // ------------------------------------------------------------
    result #(.WIDTH(WIDTH)) u_result (
        .A(A_reg),
        .B(B_reg),
        .C(C_reg),
        .D(D_reg),
        .out(out_put)
    );

endmodule
