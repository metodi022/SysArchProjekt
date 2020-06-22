module AluTestBench(); // Alu Test Bench #3

always // Clock with #1 tick
begin
	clk <= 1'b1; #1; clk <= 1'b0; #1;
end

// Input for module
reg [31:0] a;
reg [31:0] b;
reg [2:0] alucontrol;
reg [31:0] result;
reg zero;

ArithmeticLogicUnit alu(.a(a), .b(b), .alucontrol(alucontrol), .result(result), .zero(zero)); // Instantiate module

initial
begin

	// Basic SLT Test #1
	alucontrol <= 3'b000; // SLT
	a <= 32'd0;
	b <= 32'd0;
	#1;
	$display("Basic SLT Test #1");
	if((result == 32'd0) & (zero == 1))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic SLT Test #2
	alucontrol <= 3'b000; // SLT
	a <= 32'd5;
	b <= 32'd2;
	#1;
	$display("Basic SLT Test #2");
	if((result == 32'd0) & (zero == 1))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic SLT Test #3
	alucontrol <= 3'b000; // SLT
	a <= 32'd7;
	b <= 32'd8;
	#1;
	$display("Basic SLT Test #3");
	if((result == 32'd1) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic SLT Test #4
	alucontrol <= 3'b000; // SLT
	a <= 32'd25;
	b <= 32'd25;
	#1;
	$display("Basic SLT Test #4");
	if((result == 32'd0) & (zero == 1))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	$finish;
end

endmodule