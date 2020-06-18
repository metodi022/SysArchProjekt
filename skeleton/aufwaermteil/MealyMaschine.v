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

	// TODO Input Stimuli

	MealyPattern machine(.clock(XXX), .i(XXX), .o(XXX));

	// TODO Überprüfe Ausgaben

endmodule

