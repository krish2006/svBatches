`timescale 1ns/1ps
module fullAdder1bit (
    input logic a, b, cin,
    output wire y, cout
);
    assign #1 y = (a ^ b) ^ cin;
    assign #1 cout = (a & b) | (b & cin) | (cin & a);

endmodule

module nrca #(
    parameter xWIDTH = 4 // Removed the trailing semicolon
) (
    input  logic [xWIDTH-1:0] A, B, // 4 bits: [3:0]
    input  logic Cin,
    output wire [xWIDTH-1:0] Y,
    output wire Cout
);

    // 1. The Internal Carry Chain
    // A 4-bit adder has 5 carry points (1 input, 3 internal, 1 output)
    wire [xWIDTH:0] carry;

    // Wire the main Cin to the start of our carry chain
    assign carry[0] = Cin;

    // 2. The Compile-Time Hardware Generator
    genvar i;
    for (i = 0; i < xWIDTH; i=i+1) begin
        // Instantiate the 1-bit adder and connect the ports dynamically
        fullAdder1bit fa (
            .a(A[i]),
            .b(B[i]),
            .cin(carry[i]),     // Input comes from current carry wire
            .y(Y[i]),
            .cout(carry[i+1])   // Output goes to the NEXT carry wire
        );
    end

    // Wire the end of our carry chain to the main Cout
    assign Cout = carry[xWIDTH];

endmodule