`timescale 1ns/1ps

module home_tb;

    reg clk;
    reg rst_n;

    reg motion_detected;
    reg dark_room;
    reg high_temp;
    reg security_mode;
    reg door_open;
    reg manual_override;

    reg [1:0] scene_select;

    wire light_pwm;
    wire fan_pwm;
    wire relay_on;
    wire alarm_on;

    // DUT Instance
    top dut (
        .clk(clk),
        .rst_n(rst_n),

        .motion_detected(motion_detected),
        .dark_room(dark_room),
        .high_temp(high_temp),
        .security_mode(security_mode),
        .door_open(door_open),
        .manual_override(manual_override),

        .scene_select(scene_select),

        .light_pwm(light_pwm),
        .fan_pwm(fan_pwm),
        .relay_on(relay_on),
        .alarm_on(alarm_on)
    );

    // Clock Generation (100 MHz)
    always #5 clk = ~clk;

    initial begin

        // VCD Dump
        $dumpfile("home.vcd");
        $dumpvars(0, home_tb);

        // Initialize Signals
        clk = 0;
        rst_n = 0;

        motion_detected = 0;
        dark_room = 0;
        high_temp = 0;
        security_mode = 0;
        door_open = 0;
        manual_override = 0;

        scene_select = 2'b00;

        // Reset
        #20;
        rst_n = 1;

        //------------------------------------------------
        // Test 1 : Motion + Dark Room -> Light ON
        //------------------------------------------------
        #50;
        scene_select = 2'b01; // Evening Scene

        motion_detected = 1;
        dark_room = 1;

        #100;

        motion_detected = 0;
        dark_room = 0;

        //------------------------------------------------
        // Test 2 : High Temperature -> Fan ON
        //------------------------------------------------
        #100;

        scene_select = 2'b10; // Work Scene

        high_temp = 1;

        #100;

        high_temp = 0;

        //------------------------------------------------
        // Test 3 : Manual Override
        //------------------------------------------------
        #100;

        manual_override = 1;

        #100;

        manual_override = 0;

        //------------------------------------------------
        // Test 4 : Security Alarm
        //------------------------------------------------
        #100;

        security_mode = 1;
        door_open = 1;

        #100;

        security_mode = 0;
        door_open = 0;

        //------------------------------------------------
        // Test 5 : Night Mode
        //------------------------------------------------
        #100;

        scene_select = 2'b11;

        #100;

        //------------------------------------------------
        // Finish Simulation
        //------------------------------------------------
        #200;

        $finish;

    end

endmodule