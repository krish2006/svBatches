module tb_and_gate;
    
    //declare signals to connect to the module
    logic test_a;
    logic test_b;
    logic test_y;

    //instantiate module for testing (dut)
    and_gate dut (
        .a(test_a),
        .b(test_b),
        .y(test_y)
    );

    //Drive signals
    initial begin
        //for gtkwave - dump file and dump signals
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_and_gate);

        $display("Starting Simulation...");

        //pass inputs and time wait
        test_a = 0; test_b = 0; #10;
        test_a = 0; test_b = 1; #10;
        test_a = 1; test_b = 0; #10;
        test_a = 1; test_b = 1; #10;

        $display("Ending Simluation...");
        $finish;
    end

endmodule