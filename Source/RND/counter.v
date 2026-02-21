module RND_counter #(
    parameter             WIDTH = 3,
    parameter             CARRYOUT = 5,
    parameter [WIDTH-1:0] INIT  = {WIDTH{1'b0}}
)  (
    input  wire                    clk,
    input  wire                    rst,
    input  wire                    init,
    input  wire                    en,
    output wire                    co
);

    reg [WIDTH-1:0] data;

    initial data = {WIDTH{1'b0}};

    always @(posedge clk or posedge rst) begin
        if (rst)
            data <= {WIDTH{1'b0}};
        else if (init)
            data <= {WIDTH{1'b0}};
        else if (en)
            data <= data + 1;
    end

    assign co = (data == CARRYOUT);

endmodule
