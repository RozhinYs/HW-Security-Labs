`timescale 1ns/1ps
module tb_trojan_adder;
    reg [3:0] A, B;
    wire [4:0] SUM;

    trojan_adder uut (.A(A), .B(B), .SUM(SUM));

    initial begin
        $display("A    B    => SUM");
        A = 4'd3; B = 4'd2; #10; $display("%d + %d = %d", A, B, SUM);
        A = 4'd5; B = 4'd7; #10; $display("%d + %d = %d", A, B, SUM);
        A = 4'd8; B = 4'd1; #10; $display("%d + %d = %d", A, B, SUM);
        $finish;
    end
endmodule
