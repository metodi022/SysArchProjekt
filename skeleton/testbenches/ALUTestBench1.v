module AluTestBench(); // Alu Test Bench #1

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

	// Basic Addition Test #1
	alucontrol <= 3'b101; // Addition
	a <= 32'd5;
	b <= 32'd7;
	#1;
	$display("Basic Addition Test #1");
	if((result == 32'd12) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Addition Test #2
	alucontrol <= 3'b101; // Addition
	a <= 32'd7;
	b <= 32'd5;
	#1;
	$display("Basic Addition Test #2");
	if((result == 32'd12) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Addition Test #3
	alucontrol <= 3'b101; // Addition
	a <= 32'd0;
	b <= 32'd0;
	#1;
	$display("Basic Addition Test #3");
	if((result == 32'd0) & (zero == 1))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Subtraction Test #1
	alucontrol <= 3'b001; // Subtraction
	a <= 32'd7;
	b <= 32'd5;
	#1;
	$display("Basic Subtraction Test #1");
	if((result == 32'd2) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Subtraction Test #2
	alucontrol <= 3'b001; // Subtraction
	a <= 32'd5;
	b <= 32'd7;
	#1;
	$display("Basic Subtraction Test #2");
	if((result == 32'b11111111111111111111111111111110) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Subtraction Test #3
	alucontrol <= 3'b001; // Subtraction
	a <= 32'd0;
	b <= 32'd0;
	#1;
	$display("Basic Subtraction Test #3");
	if((result == 32'd0) & (zero == 1))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Subtraction Test #4
	alucontrol <= 3'b001; // Subtraction
	a <= 32'd10;
	b <= 32'd10;
	#1;
	$display("Basic Subtraction Test #4");
	if((result == 32'd0) & (zero == 1))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	$finish;
end

endmodule