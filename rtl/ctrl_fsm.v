module ctrl_fsm (
    input  wire clk,
    input  wire rst_n,

    input  wire motion_detected,
    input  wire dark_room,
    input  wire high_temp,
    input  wire security_mode,
    input  wire door_open,
    input  wire manual_override,

    output reg  light_on,
    output reg  fan_on,
    output reg  ac_on,
    output reg  alarm_on
);

    localparam IDLE   = 2'b00;
    localparam AUTO   = 2'b01;
    localparam MANUAL = 2'b10;
    localparam ALARM  = 2'b11;

    reg [1:0] state, next_state;

    // State Register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (state)

            IDLE: begin
                if (security_mode && door_open)
                    next_state = ALARM;
                else if (manual_override)
                    next_state = MANUAL;
                else if (motion_detected || high_temp)
                    next_state = AUTO;
                else
                    next_state = IDLE;
            end

            AUTO: begin
                if (security_mode && door_open)
                    next_state = ALARM;
                else if (manual_override)
                    next_state = MANUAL;
                else
                    next_state = AUTO;
            end

            MANUAL: begin
                if (security_mode && door_open)
                    next_state = ALARM;
                else if (!manual_override)
                    next_state = IDLE;
                else
                    next_state = MANUAL;
            end

            ALARM: begin
                if (!(security_mode && door_open))
                    next_state = IDLE;
                else
                    next_state = ALARM;
            end

            default:
                next_state = IDLE;

        endcase
    end

    // Output Logic
    always @(*) begin

        light_on = 1'b0;
        fan_on   = 1'b0;
        ac_on    = 1'b0;
        alarm_on = 1'b0;

        case (state)

            IDLE: begin
                light_on = 1'b0;
                fan_on   = 1'b0;
                ac_on    = 1'b0;
            end

            AUTO: begin
                if (motion_detected && dark_room)
                    light_on = 1'b1;

                if (high_temp) begin
                    fan_on = 1'b1;
                    ac_on  = 1'b1;
                end
            end

            MANUAL: begin
                light_on = 1'b1;
                fan_on   = 1'b1;
            end

            ALARM: begin
                alarm_on = 1'b1;
            end

        endcase
    end

endmodule