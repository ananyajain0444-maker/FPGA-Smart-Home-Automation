module top (
    input  wire clk,
    input  wire rst_n,

    input  wire motion_detected,
    input  wire dark_room,
    input  wire high_temp,
    input  wire security_mode,
    input  wire door_open,
    input  wire manual_override,

    input  wire [1:0] scene_select,

    output wire light_pwm,
    output wire fan_pwm,
    output wire relay_on,
    output wire alarm_on
);

    // FSM Outputs
    wire light_ctrl;
    wire fan_ctrl;
    wire ac_ctrl;

    // Scene Outputs
    wire [7:0] scene_light_duty;
    wire [7:0] scene_fan_duty;
    wire scene_relay;

    // Actual PWM Duty Values
    wire [7:0] light_duty;
    wire [7:0] fan_duty;

    // FSM Instance
    ctrl_fsm u_fsm (
        .clk(clk),
        .rst_n(rst_n),

        .motion_detected(motion_detected),
        .dark_room(dark_room),
        .high_temp(high_temp),
        .security_mode(security_mode),
        .door_open(door_open),
        .manual_override(manual_override),

        .light_on(light_ctrl),
        .fan_on(fan_ctrl),
        .ac_on(ac_ctrl),
        .alarm_on(alarm_on)
    );

    // Scene Controller Instance
    scenes u_scenes (
        .scene_select(scene_select),
        .light_duty(scene_light_duty),
        .fan_duty(scene_fan_duty),
        .relay_on(scene_relay)
    );

    // PWM Duty Assignment
    assign light_duty = light_ctrl ? scene_light_duty : 8'd0;
    assign fan_duty   = fan_ctrl   ? scene_fan_duty   : 8'd0;

    // PWM Generators
    pwm8 u_light_pwm (
        .clk(clk),
        .rst_n(rst_n),
        .duty_cycle(light_duty),
        .pwm_out(light_pwm)
    );

    pwm8 u_fan_pwm (
        .clk(clk),
        .rst_n(rst_n),
        .duty_cycle(fan_duty),
        .pwm_out(fan_pwm)
    );

    // Relay Control
    assign relay_on = scene_relay;

endmodule