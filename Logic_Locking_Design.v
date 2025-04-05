// ================================================
// Locked 4-bit Adder in Verilog 2001
// Demonstrates XOR-based logic locking
// ================================================

module locked_adder (
    A, B, key, SUM
);

    input [3:0] A, B;
    input [3:0] key;
    output [4:0] SUM;

    wire [3:0] A_locked;
    wire [3:0] B_locked;

    // Lock the inputs using XOR
    assign A_locked = A ^ key;
    assign B_locked = B ^ key;

    // Add locked inputs
    assign SUM = (A_locked ^ 4'b1101) + (B_locked ^ 4'b1101);

endmodule
