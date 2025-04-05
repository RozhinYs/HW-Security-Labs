module trojan_adder (
    input [3:0] A,
    input [3:0] B,
    output [4:0] SUM
);
    // Normal addition
    assign SUM = (A == 4'b1010 && B == 4'b1010) ? 5'b11111 : A + B;  // Trojan activates only when A and B are 10
endmodule
