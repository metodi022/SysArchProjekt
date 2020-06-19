module MealyPattern(
	input        clock,
	input        i,
	output [1:0] o
);
	reg [2:0] q = 3'b000;
	always @(posedge clock)
		begin
			q = q << 1;
			q[0] = i;
			if((q == 3'b111) | (q == 3'b001))
				o = 2'b10;
			else
				o = 2'b00;
		end

endmodule



module MealyPatternTestbench();

    reg clk, in, tmp;
    
    initial
    begin
        $dumpfile("MealyMaschine.vcd");
        $dumpvars;
        
        assign in = 10'b1110011001
        
        // part of in is written into tmp for easier validation
        // and update in accordingly
        tmp <= in [9:7];
        in <= in << 3;
        
        
        // check if output was as expected
        if (((tmp == 3'b111) | (tmp == 3'b001)) & (out == 2'b01))
            $display ("CORRECT: input was %h and output was %h", tmp, out);
        else
            $display ("WRONG: input was %h and output was %h", tmp, out);
        
        $finish;
    end
    
    
    // input tmp for machine
    wire [1:0] out;
    MealyPattern machine(.clock(clk), .i(tmp), .o(out));
        

    // create clock
    always
    begin
        clk <= 1'b1; #1; clk <= 1'b0; #1;
    end

endmodule

