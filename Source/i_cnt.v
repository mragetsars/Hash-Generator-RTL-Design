module i_cnt #(
    parameter WIDTH = 6
)(
    input  wire                 clk,
    input  wire                 rst,
    input  wire                 inc,
    output reg  [WIDTH-1:0]     i_out,
    output wire                 i_is_all_one
);

    // counter
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            i_out <= {WIDTH{1'b0}};
        end else if (inc) begin
            i_out <= i_out + 1'b1;
        end
    end

    assign i_is_all_one = &i_out;

endmodule
