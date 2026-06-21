module debounce (
    input  wire clk,
    input  wire rst_n,
    input  wire btn_in,
    output reg  btn_out
);

    reg [15:0] counter;
    reg btn_sync;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter  <= 16'd0;
            btn_sync <= 1'b0;
            btn_out  <= 1'b0;
        end
        else begin

            if (btn_in != btn_sync) begin
                counter <= counter + 1'b1;

                if (counter == 16'hFFFF) begin
                    btn_sync <= btn_in;
                    btn_out  <= btn_in;
                    counter  <= 16'd0;
                end
            end
            else begin
                counter <= 16'd0;
            end

        end
    end

endmodule