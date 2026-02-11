`timescale 1ns / 1ps
// Fixed-point Multiplier (Q8.8 format)
module multiplier (
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [31:0] out
);
    // Based on your Q16.16 code logic
    wire signed [63:0] prod = a * b;
    assign out = prod[47:16]; // Corrected scaling for Q16.16
endmodule