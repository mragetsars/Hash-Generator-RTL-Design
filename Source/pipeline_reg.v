module pipeline_reg #(
    parameter WIDTH = 32,
    parameter [WIDTH-1:0] INIT = {WIDTH{1'b0}}
) (
    input  wire [WIDTH-1:0] d_in,
    input  wire             load_enable,
    input  wire             rst,
    input  wire             clk,
    output reg  [WIDTH-1:0] q_out
);

    initial q_out = INIT;

    always @(posedge clk or posedge rst) begin
        if (rst)
            q_out <= INIT;
        else if (load_enable)
            q_out <= d_in;
    end
endmodule