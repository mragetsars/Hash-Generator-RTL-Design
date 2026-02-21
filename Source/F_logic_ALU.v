module F_logic_ALU #(
parameter WIDTH = 32
)(
input  wire [WIDTH-1:0] B,
input  wire [WIDTH-1:0] C,
input  wire [WIDTH-1:0] D,
input  wire [1:0]       func_sel,
output reg  [WIDTH-1:0] F_logic
);

always @(*) begin
    case (func_sel)
        2'b00: F_logic = (B & C) | ((~B) & D);
        2'b01: F_logic = (D & B) | ((~D) & C);
        2'b10: F_logic = B ^ C ^ D;
        2'b11: F_logic = C ^ (B | (~D));
        default: F_logic = {WIDTH{1'b0}};
    endcase
end

endmodule
