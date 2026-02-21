module RND_xor (
    input  wire in_1,
    input  wire in_2,
    output wire out
);

    assign out = in_1 ^ in_2;

endmodule