module edge_ai_accelerator (
    input  wire        clk,
    input  wire        reset,
    input  wire        start,

    input  wire signed [7:0] x0,
    input  wire signed [7:0] x1,
    input  wire signed [7:0] x2,
    input  wire signed [7:0] x3,

    input  wire signed [7:0] w0,
    input  wire signed [7:0] w1,
    input  wire signed [7:0] w2,
    input  wire signed [7:0] w3,

    input  wire signed [15:0] bias,

    output reg signed [15:0] result,
    output reg        valid,
    output reg        busy
);

    // FSM states
    localparam IDLE = 3'b000;
    localparam MAC  = 3'b001;
    localparam BIAS = 3'b010;
    localparam RELU = 3'b011;
    localparam DONE = 3'b100;

    reg [2:0] state;

    reg signed [31:0] accumulator;

    reg signed [7:0] x0_reg;
    reg signed [7:0] x1_reg;
    reg signed [7:0] x2_reg;
    reg signed [7:0] x3_reg;

    reg signed [7:0] w0_reg;
    reg signed [7:0] w1_reg;
    reg signed [7:0] w2_reg;
    reg signed [7:0] w3_reg;

    reg signed [15:0] bias_reg;

    reg signed [31:0] final_value;

    always @(posedge clk or posedge reset) begin

        if (reset) begin

            state       <= IDLE;
            accumulator <= 0;
            final_value <= 0;

            result      <= 0;
            valid       <= 0;
            busy        <= 0;

        end

        else begin

            case (state)

                // -------------------------
                // IDLE
                // -------------------------
                IDLE: begin

                    valid <= 0;
                    busy  <= 0;

                    if (start) begin

                        x0_reg <= x0;
                        x1_reg <= x1;
                        x2_reg <= x2;
                        x3_reg <= x3;

                        w0_reg <= w0;
                        w1_reg <= w1;
                        w2_reg <= w2;
                        w3_reg <= w3;

                        bias_reg <= bias;

                        accumulator <= 0;

                        busy <= 1;

                        state <= MAC;

                    end

                end

                // -------------------------
                // MAC
                // -------------------------
                MAC: begin

                    accumulator <=
                        ($signed(x0_reg) * $signed(w0_reg)) +
                        ($signed(x1_reg) * $signed(w1_reg)) +
                        ($signed(x2_reg) * $signed(w2_reg)) +
                        ($signed(x3_reg) * $signed(w3_reg));

                    state <= BIAS;

                end

                // -------------------------
                // BIAS
                // -------------------------
                BIAS: begin

                    final_value <=
                        accumulator + $signed(bias_reg);

                    state <= RELU;

                end

                // -------------------------
                // RELU
                // -------------------------
                RELU: begin

                    if (final_value < 0)
                        result <= 16'd0;
                    else
                        result <= final_value[15:0];

                    state <= DONE;

                end

                // -------------------------
                // DONE
                // -------------------------
                DONE: begin

                    valid <= 1;
                    busy  <= 0;

                    state <= IDLE;

                end

                default: begin

                    state <= IDLE;
                    busy  <= 0;
                    valid <= 0;

                end

            endcase

        end

    end

endmodule