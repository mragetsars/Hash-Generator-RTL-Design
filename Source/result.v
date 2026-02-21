module result #(
    parameter integer WIDTH = 128,
    parameter integer WORD  = WIDTH / 4
)(
    input  [WORD-1:0] A,
    input  [WORD-1:0] B,
    input  [WORD-1:0] C,
    input  [WORD-1:0] D,
    output [WIDTH-1:0] out
);

assign out = {A, B, C, D};

endmodule