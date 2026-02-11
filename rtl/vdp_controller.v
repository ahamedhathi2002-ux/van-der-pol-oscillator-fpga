`timescale 1ns / 1ps
module vdp_controller (
    input clk, reset, start,
    output reg [2:0] state,
    output reg [1:0] mux_sel,
    output reg alu_sub,
    output reg done
);
    localparam IDLE=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin done <= 0; if (start) state <= S1; end
                S1: state <= S2;
                S2: state <= S3;
                S3: state <= S4;
                S4: begin done <= 1; state <= IDLE; end
                default: state <= IDLE;
            endcase
        end
    end

    always @(*) begin
        case (state)
            S1: begin mux_sel = 2'b00; alu_sub = 0; end // V1, V3, V8 [cite: 61, 226]
            S2: begin mux_sel = 2'b01; alu_sub = 0; end // V2, V4, V7 [cite: 61, 226]
            S3: begin mux_sel = 2'b10; alu_sub = 1; end // V5 [cite: 61, 226]
            S4: begin mux_sel = 2'b11; alu_sub = 1; end // V6 [cite: 61, 226]
            default: begin mux_sel = 2'b00; alu_sub = 0; end
        endcase
    end
endmodule