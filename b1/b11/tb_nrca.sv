`timescale 1ns/1ps
module tb_nrca;

    // 1. Declare the parameter FIRST
    parameter tWIDTH = 4;

    // 2. Declare signals (Notice the semicolons!)
    logic [tWIDTH-1:0] AA, BB; 
    logic CCin;
    logic [tWIDTH-1:0] YY;
    logic CCout;
    
    // 3. Instantiate module and pass the parameter
    nrca #(.xWIDTH(tWIDTH)) dut (
        .A(AA),
        .B(BB),
        .Cin(CCin),
        .Y(YY),
        .Cout(CCout)
    );

    // 4. Start sim
    initial begin
        // For GTKWave and execution engine
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_nrca);

        $display("Simulation Starting...");

        // TESTCASE 1: Baseline zero
        AA = 4'b0000; BB = 4'b0000; CCin = 0;
        #10; // Wait 10ns

        // TESTCASE 2: The Worst-Case Ripple
        // Adding 1 to 15 forces the carry bit to travel through all 4 adders
        AA = 4'b0001; BB = 4'b1111; CCin = 0;
        #20; // Give it plenty of time to ripple before finishing

        $display("Simulation Completed...");
        $finish; // Added the missing semicolon here too!
    end

endmodule