module calib_tb;
    // 1. Declare a physical wire
    logic test_wire;

    initial begin
        // 2. Tell the compiler to record the physics to a file
        $dumpfile("calib.vcd");
        $dumpvars(0, calib_tb);

        // 3. Force the wire to toggle with artificial time delays (#10)
        test_wire = 0;
        #10 test_wire = 1;
        #10 test_wire = 0;
        
        // 4. Kill the simulation
        #10 $finish; 
    end
endmodule