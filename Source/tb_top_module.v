`timescale 1ns/1ps

module tb_top_module;

    // Parameters (match top_module defaults)
    parameter integer WIDTH = 128;
    localparam integer WORD  = WIDTH / 4; // 32
    localparam MEM_PATH = "constant.mem"; //!

    // Clock / reset / control signals
    reg clk;
    reg rst;
    reg start;
    reg [WIDTH-1:0] in_put;

    // Outputs from DUT
    wire done;
    wire [WIDTH-1:0] out_put;

    // Helper variables (declared at module scope for Verilog-2001)
    integer wait_cycles;

    // Instantiate DUT
    top_module #(.WIDTH(WIDTH), .MEM_PATH(MEM_PATH)) DUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .in_put(in_put),
        .done(done),
        .out_put(out_put)
    );

    // Clock generator: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test procedure
    initial begin
        // Dump waves (optional)
        $dumpfile("tb_top_module.vcd");
        $dumpvars(0, tb_top_module);

        // Initialize inputs
        rst   = 1'b1;
        start = 1'b0;

        // Message: 00000000000000000000000000000000
        // 32 hex digits = 128 bits; most-significant nibble on left
        in_put = 128'h00000000000000000000000000000000;

        // Hold reset for a few cycles
        #25;
        rst = 1'b0;

        // Give a short settle time
        #20;

        // Pulse start for one clock cycle (adjust if your controller expects other handshakes)
        @(posedge clk);
        start = 1'b1;
        @(posedge clk);
        start = 1'b0;

        // Wait for done, with timeout
        wait_cycles = 0;
        while (!done && wait_cycles < 10000) begin
            @(posedge clk);
            wait_cycles = wait_cycles + 1;
        end

        if (done) begin
            // Print output as hex (WORD bits)
            $display("Simulation finished: done asserted after %0d cycles.", wait_cycles);
            $display("out_put = %0h", out_put);
        end else begin
            $display("Timeout: 'done' not asserted after %0d cycles. Increase timeout or check controller.", wait_cycles);
        end

        #10;
        $finish;
    end

endmodule
