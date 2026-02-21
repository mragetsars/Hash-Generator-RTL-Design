module B_adder #(
    parameter WIDTH = 32
)(
    input  [WIDTH-1:0] B_old,
    input  [WIDTH-1:0] rotF,
    output [WIDTH-1:0] B_plus_rotF
);

assign B_plus_rotF = B_old + rotF;

endmodule
