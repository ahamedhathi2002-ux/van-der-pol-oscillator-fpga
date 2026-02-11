`timescale 1ns / 1ps
module vdp_top (
    input clk, reset, start,
    input signed [31:0] ext_mu, ext_dt, ext_a,
    output signed [31:0] x_out,
    output done
);
    // 9 Registers: R1-R8 (data) and R9 (boolean C) [cite: 210, 327]
    reg signed [31:0] R1, R2, R3, R4, R5, R6, R7, R8;
    reg R9;

    wire [2:0] state;
    wire [1:0] mux_ctrl;
    wire sub_bit;
    wire signed [31:0] m1_out, m2_out, alu_out;
    wire c_out;
    reg signed [31:0] m1_a, m1_b, m2_a, m2_b, alu_a, alu_b;

    // Instantiate Sub-modules [cite: 173, 211, 212, 213]
    vdp_controller CU (clk, reset, start, state, mux_ctrl, sub_bit, done);
    multiplier M1 (m1_a, m1_b, m1_out);
    multiplier M2 (m2_a, m2_b, m2_out);
    alu_add_sub ALU (alu_a, alu_b, sub_bit, alu_out);
    comparator COM (R7, R8, c_out);

    // Mux Stages based on Lecture Scheduling [cite: 265, 327]
    always @(*) begin
        case (mux_ctrl)
            2'b00: begin // S1
                m1_a = R3; m1_b = R4; // u * dt
                m2_a = R4; m2_b = R6; // y * dt
                alu_a = R4; alu_b = R7; // dt + t
            end
            2'b01: begin // S2
                m1_a = R1; m1_b = R5; // mu * (u*dt) -> Simplified for flow
                m2_a = R5; m2_b = R2; 
                alu_a = R1; alu_b = R6; // y + (u*dt)
            end
            2'b10: begin alu_a = R1; alu_b = R3; end // S3: u - t2
            2'b11: begin alu_a = R1; alu_b = R2; end // S4: t5 - t4
            default: begin m1_a = 0; m1_b = 0; m2_a = 0; m2_b = 0; alu_a = 0; alu_b = 0; end
        endcase
    end

    // Register Update Logic [cite: 226, 327]
    always @(posedge clk) begin
        if (reset) begin
            R3 <= 0; R6 <= 32'h00010000; R7 <= 0; // Initialize u, y, t
        end else if (start && state == 3'd0) begin
            R4 <= ext_dt; R5 <= ext_mu; R8 <= ext_a; // Load inputs [cite: 81]
        end else begin
            case (state)
                3'd1: begin R1 <= m1_out; R2 <= m2_out; R7 <= alu_out; R9 <= c_out; end
                3'd2: begin R1 <= m1_out; R2 <= m2_out; R6 <= alu_out; end
                3'd3: begin R1 <= alu_out; end
                3'd4: begin R3 <= alu_out; end
            endcase
        end
    end
    assign x_out = R6;
endmodule


