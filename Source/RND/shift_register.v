module RND_shift_register #(
    parameter             WIDTH = 8,
    parameter [WIDTH-1:0] INIT  = {WIDTH{1'b0}}
) (
    input  wire             clk,
    input  wire             rst,
    input  wire [WIDTH-1:0] seed,
    input  wire             fb,       
    input  wire             init,
    input  wire             en,
    output wire             out
);

    reg [WIDTH-1:0] data;

    initial data = {WIDTH{1'b0}};

    always @(posedge clk or posedge rst) begin
        if (rst)
            data <= {WIDTH{1'b0}};
        else if (init)
            data <= seed;
        else if (en)
            data <= {data[WIDTH-2:0], fb};
    end

    assign out = data;

endmodule