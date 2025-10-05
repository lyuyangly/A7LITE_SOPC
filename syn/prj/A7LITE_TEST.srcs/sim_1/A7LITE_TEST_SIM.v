`timescale 1ns / 1ps
module A7LITE_TEST_SIM();

reg         clk;
reg         rst_n;

initial forever #10 clk = ~clk;

A7LITE_TEST U_DUT (
    .CLK_50M    (clk    ),
    .RESET_N    (rst_n  )
);

initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    repeat(10) @(posedge clk);
    rst_n = 1'b1;
    #1000000000;
    $finish;
end

endmodule