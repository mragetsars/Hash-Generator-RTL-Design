module left_rotate_with_step #(parameter WIDTH = 32) (
    input  wire [WIDTH-1:0] val_in,
    input  wire [5:0]       i_in,
    output wire [WIDTH-1:0] rotF
);

    reg [4:0] shift;

    always @(*) begin
        case (i_in)
            // first 16 entries: pattern 7,12,17,22 repeated
            6'd0:  shift = 5'd7;  6'd1:  shift = 5'd12; 6'd2:  shift = 5'd17; 6'd3:  shift = 5'd22;
            6'd4:  shift = 5'd7;  6'd5:  shift = 5'd12; 6'd6:  shift = 5'd17; 6'd7:  shift = 5'd22;
            6'd8:  shift = 5'd7;  6'd9:  shift = 5'd12; 6'd10: shift = 5'd17; 6'd11: shift = 5'd22;
            6'd12: shift = 5'd7;  6'd13: shift = 5'd12; 6'd14: shift = 5'd17; 6'd15: shift = 5'd22;

            // next 16 entries: pattern 5,9,14,20 repeated
            6'd16: shift = 5'd5;  6'd17: shift = 5'd9;  6'd18: shift = 5'd14; 6'd19: shift = 5'd20;
            6'd20: shift = 5'd5;  6'd21: shift = 5'd9;  6'd22: shift = 5'd14; 6'd23: shift = 5'd20;
            6'd24: shift = 5'd5;  6'd25: shift = 5'd9;  6'd26: shift = 5'd14; 6'd27: shift = 5'd20;
            6'd28: shift = 5'd5;  6'd29: shift = 5'd9;  6'd30: shift = 5'd14; 6'd31: shift = 5'd20;

            // next 16 entries: pattern 4,11,16,23 repeated
            6'd32: shift = 5'd4;  6'd33: shift = 5'd11; 6'd34: shift = 5'd16; 6'd35: shift = 5'd23;
            6'd36: shift = 5'd4;  6'd37: shift = 5'd11; 6'd38: shift = 5'd16; 6'd39: shift = 5'd23;
            6'd40: shift = 5'd4;  6'd41: shift = 5'd11; 6'd42: shift = 5'd16; 6'd43: shift = 5'd23;
            6'd44: shift = 5'd4;  6'd45: shift = 5'd11; 6'd46: shift = 5'd16; 6'd47: shift = 5'd23;

            // last 16 entries: pattern 6,10,15,21 repeated
            6'd48: shift = 5'd6;  6'd49: shift = 5'd10; 6'd50: shift = 5'd15; 6'd51: shift = 5'd21;
            6'd52: shift = 5'd6;  6'd53: shift = 5'd10; 6'd54: shift = 5'd15; 6'd55: shift = 5'd21;
            6'd56: shift = 5'd6;  6'd57: shift = 5'd10; 6'd58: shift = 5'd15; 6'd59: shift = 5'd21;
            6'd60: shift = 5'd6;  6'd61: shift = 5'd10; 6'd62: shift = 5'd15; 6'd63: shift = 5'd21;

            default: shift = 5'd0;
        endcase
    end

    assign rotF = (val_in << shift) | (val_in >> (WIDTH - shift));

endmodule
