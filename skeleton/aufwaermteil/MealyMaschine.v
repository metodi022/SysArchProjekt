module MealyPattern(
    input        clock,
    input        i,
    output [1:0] o
);
    reg [2:0] q = 3'b000;
    reg [1:0] out = 2'b00;
    always @(posedge clock)
        begin
            q = q << 1;
            q[0] = i;
            if((q == 3'b111) | (q == 3'b001))
                out <= 2'b10;
            else
                out <= 2'b00;
        end
    
    assign o = out;
    
endmodule


module MealyPatternTestbench();
    
    //10b'1110011001
    reg clk, in;
    
    
    initial
    begin
        $dumpfile("MealyPattern.vcd");
        $dumpvars;
    
        in <= 1'b1;
        #1;
        in <= 1'b1;
        #1;
        in <= 1'b1;
        #1;
        in <= 1'b0;
        #1;
        in <= 1'b0;
        #1;
        in <= 1'b1;
        #1;
        in <= 1'b1;
        #1;
        in <= 1'b0;
        #1;
        in <= 1'b0;
        #1;
        in <= 1'b1;
        #1;
        
        $finish;
    end
    
    
    wire [1:0] out;
    MealyPattern machine(.clock(clk), .i(in), .o(out));
    
    
    
    always
    begin
        clk <= 1'b0; #1; clk <= 1'b1; #1;
    end

endmodule
