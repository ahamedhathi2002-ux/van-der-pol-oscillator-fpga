`timescale 1ns / 1ps
// Functional Unit for Addition/Subtraction [cite: 212]
module alu_add_sub (
    input signed [31:0] a,
    input signed [31:0] b,
    input sub_ctrl, // 0 for Add, 1 for Subtract
    output signed [31:0] out
);
    assign out = sub_ctrl ? (a - b) : (a + b);
endmodule