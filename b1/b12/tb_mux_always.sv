`timescale 1ns/1ps
module tb_mux_always;

    //define test signals
    logic [2:0] test_a, test_b, test_c, test_d;
    logic [1:0] test_select;
    logic [2:0] test_y;

    //instantiate mux
    mux_always dut (
        .a(test_a),
        .b(test_b),
        .c(test_c),
        .d(test_d),
        .select(test_select),
        .y(test_y)
    );

    //start sim
    initial begin
        //for gtkwave and execution engine
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_mux_always);
        $display("Starting Simulation...");

        test_a = 3'b100; test_b = 3'b101; test_c = 3'b011; test_d = 3'b001;
        test_select = 2'b00; #10;
        test_select = 2'b01; #10;
        test_select = 2'b10; #10;
        test_select = 2'b11; #10;

        $display("Ending Simulation...");
        $finish;
    end

endmodule