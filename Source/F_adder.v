module F_adder #(
parameter WIDTH = 8
)(
input  wire [WIDTH-1:0] F_logic,
input  wire [WIDTH-1:0] A,
input  wire [WIDTH-1:0] const_word,
input  wire [WIDTH-1:0] m_word,
output wire [WIDTH-1:0] F_sum
);

assign F_sum = F_logic + A + const_word + m_word;

endmodule
