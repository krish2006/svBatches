module mux_always (
    input logic [2:0] a, b, c, d,
    input logic [1:0] select,
    output logic [2:0] y
);
    always_comb begin : mux_implementation
        case (select)
            2'b00: y = a;
            2'b01: y = b;
            //2'b10: y = c;
            2'b11: y = d; 
            default: y = 3'bxxx;
        endcase
    end
endmodule