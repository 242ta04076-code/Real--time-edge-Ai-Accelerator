`timescale 1ns/1ps

module edge_ai_accelerator_tb;

    reg clk;
    reg reset;
    reg start;

    reg signed [7:0] x0;
    reg signed [7:0] x1;
    reg signed [7:0] x2;
    reg signed [7:0] x3;

    reg signed [7:0] w0;
    reg signed [7:0] w1;
    reg signed [7:0] w2;
    reg signed [7:0] w3;

    reg signed [15:0] bias;

    wire signed [15:0] result;
    wire valid;
    wire busy;


    // Instantiate accelerator
    edge_ai_accelerator uut (

        .clk(clk),
        .reset(reset),
        .start(start),

        .x0(x0),
        .x1(x1),
        .x2(x2),
        .x3(x3),

        .w0(w0),
        .w1(w1),
        .w2(w2),
        .w3(w3),

        .bias(bias),

        .result(result),
        .valid(valid),
        .busy(busy)

    );


    // Clock
    always #5 clk = ~clk;


    initial begin

        // Generate waveform
        $dumpfile("waveform.vcd");
        $dumpvars(0, edge_ai_accelerator_tb);


        // Initial values
        clk   = 0;
        reset = 1;
        start = 0;

        x0 = 0;
        x1 = 0;
        x2 = 0;
        x3 = 0;

        w0 = 0;
        w1 = 0;
        w2 = 0;
        w3 = 0;

        bias = 0;


        // Reset
        #10;
        reset = 0;


        // =====================================
        // TEST 1
        // Expected result = 13
        // =====================================

        x0 = 2;
        x1 = 3;
        x2 = 1;
        x3 = 2;

        w0 = 2;
        w1 = 1;
        w2 = 3;
        w3 = 1;

        bias = 1;

        start = 1;

        #10;

        start = 0;


        wait(valid);

        $display("TEST 1");
        $display("Expected Result = 13");
        $display("Actual Result   = %d", result);


        #20;


        // =====================================
        // TEST 2
        // Negative result
        // ReLU should produce 0
        // =====================================

        x0 = 2;
        x1 = 2;
        x2 = 1;
        x3 = 1;

        w0 = -2;
        w1 = -2;
        w2 = -1;
        w3 = -1;

        bias = 0;

        start = 1;

        #10;

        start = 0;


        wait(valid);

        $display("TEST 2");
        $display("Expected Result = 0");
        $display("Actual Result   = %d", result);


        #20;


        // =====================================
        // TEST 3
        // Expected result = 30
        // =====================================

        x0 = 5;
        x1 = 4;
        x2 = 3;
        x3 = 2;

        w0 = 2;
        w1 = 2;
        w2 = 2;
        w3 = 2;

        bias = 2;

        start = 1;

        #10;

        start = 0;


        wait(valid);

        $display("TEST 3");
        $display("Expected Result = 30");
        $display("Actual Result   = %d", result);


        #20;

        $finish;

    end


    initial begin

        $monitor(
            "Time=%0t Start=%b Busy=%b Valid=%b Result=%d",
            $time,
            start,
            busy,
            valid,
            result
        );

    end

endmodule