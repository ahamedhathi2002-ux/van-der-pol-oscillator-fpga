`timescale 1ns / 1ps
// Logic for stopping criteria V9 (t < a) [cite: 114, 213]
module comparator (
    input signed [31:0] t,
    input signed [31:0] a_limit,
    output out_bool
);
    assign out_bool = (t < a_limit); // V9: t < a stopping criteria [cite: 61, 114]
endmodule