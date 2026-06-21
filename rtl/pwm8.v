module pwm8 (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [7:0] duty_cycle,
    output reg        pwm_out
);

    reg [7:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 8'd0;
            pwm_out <= 1'b0;
        end
        else begin
            counter <= counter + 1'b1;

            if (counter < duty_cycle)
                pwm_out <= 1'b1;
            else
                pwm_out <= 1'b0;
        end
    end

endmodule