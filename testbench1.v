// ================================================
// Testbench for locked_adder in Verilog 2001
// Try different key values to observe correct/incorrect results
// ================================================

`timescale 1ns/1ps

module tb;

    reg [3:0] A, B;
    reg [3:0] key;
    wire [4:0] SUM;

    // Instantiate the Unit Under Test (UUT)
    locked_adder uut (
        .A(A),
        .B(B),
        .key(key),
        .SUM(SUM)
    );

    initial begin
        $display(" A     B     Key   =>   SUM");
        $display("==============================");

        // Test with  Wrong key
        A = 4'b0011; B = 4'b0101; key = 4'b0000; #10;
        $display("%b  %b  %b  =>  %b", A, B, key, SUM);


        $finish;
    end

endmodule
