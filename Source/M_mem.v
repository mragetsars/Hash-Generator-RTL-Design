module M_mem #(
parameter WIDTH = 128
)(
input  wire              clk,
input  wire              load_msg,
input  wire [WIDTH-1:0]  msg_in,
output reg  [WIDTH/4-1:0] M_out_1,
output reg  [WIDTH/4-1:0] M_out_2,
output reg  [WIDTH/4-1:0] M_out_3,
output reg  [WIDTH/4-1:0] M_out_4
);

always @(posedge clk) begin
    if (load_msg) begin
        M_out_1 <= msg_in[(WIDTH/4)*4 - 1 : (WIDTH/4)*3]; //! this is MSBs
        M_out_2 <= msg_in[(WIDTH/4)*3 - 1 : (WIDTH/4)*2];
        M_out_3 <= msg_in[(WIDTH/4)*2 - 1 : (WIDTH/4)*1];
        M_out_4 <= msg_in[(WIDTH/4)*1 - 1 : (WIDTH/4)*0];
    end
end

endmodule
