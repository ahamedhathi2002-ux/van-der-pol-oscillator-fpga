`timescale 1ns / 1ps

module tb_vdp();
    reg clk=0, reset=1, start=0;
    reg signed [31:0] mu, dt, a;
    wire signed [31:0] x;
    wire done;
    integer f_out, i;

    vdp_top uut (clk, reset, start, mu, dt, a, x, done);
    always #5 clk = ~clk;

    initial begin
        mu = 32'h00020000; dt = 32'h00008000; a = 32'h00100000; // Param values
        f_out = $fopen("vdp_output.csv", "w");
        $fdisplay(f_out, "Iteration, X_Decimal");
        
        #20 reset = 0;
        for (i=0; i<500; i=i+1) begin
            @(posedge clk); start = 1;
            @(posedge clk); start = 0;
            wait(done);
            $fdisplay(f_out, "%d, %f", i, $itor(x)/65536.0);
            $fflush(f_out);
        end
        $fclose(f_out);
        $finish;
    end
endmodule