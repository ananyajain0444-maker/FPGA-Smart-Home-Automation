module scenes (
    input  wire [1:0] scene_select,

    output reg [7:0] light_duty,
    output reg [7:0] fan_duty,
    output reg       relay_on
);

    always @(*) begin

        case (scene_select)

            // Scene 0 : All OFF
            2'b00: begin
                light_duty = 8'd0;
                fan_duty   = 8'd0;
                relay_on   = 1'b0;
            end

            // Scene 1 : Evening Mode
            2'b01: begin
                light_duty = 8'd80;
                fan_duty   = 8'd50;
                relay_on   = 1'b1;
            end

            // Scene 2 : Work Mode
            2'b10: begin
                light_duty = 8'd200;
                fan_duty   = 8'd150;
                relay_on   = 1'b1;
            end

            // Scene 3 : Night Mode
            2'b11: begin
                light_duty = 8'd30;
                fan_duty   = 8'd0;
                relay_on   = 1'b0;
            end

            default: begin
                light_duty = 8'd0;
                fan_duty   = 8'd0;
                relay_on   = 1'b0;
            end

        endcase

    end

endmodule