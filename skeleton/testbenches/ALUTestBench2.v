module AluTestBench(); // Alu Test Bench #2

reg clk;

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
	
	// Basic Logic And Test #1
	alucontrol <= 3'b111; // And
	a <= 32'b11111111111111111111111111111111;
	b <= 32'b11111111111111111111111111111111;
	#1;
	$display("Basic Logic And Test #1");
	if((result == 32'b11111111111111111111111111111111) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Logic And Test #2
	alucontrol <= 3'b111; // And
	a <= 32'b00000000000000000000000000000000;
	b <= 32'b11111111111111111111111111111111;
	#1;
	$display("Basic Logic And Test #2");
	if((result == 32'b00000000000000000000000000000000) & (zero == 1))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Logic And Test #3
	alucontrol <= 3'b111; // And
	a <= 32'b01010101010101010101010101010101;
	b <= 32'b10101010101010101010101010101010;
	#1;
	$display("Basic Logic And Test #3");
	if((result == 32'b00000000000000000000000000000000) & (zero == 1))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Logic And Test #4
	alucontrol <= 3'b111; // And
	a <= 32'd5;
	b <= 32'd6;
	#1;
	$display("Basic Logic And Test #4");
	if((result == 32'd4) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Logic And Test #5
	alucontrol <= 3'b111; // And
	a <= 32'b00000000000000000000000000000000;
	b <= 32'b00000000000000000000000000000000;
	#1;
	$display("Basic Logic And Test #5");
	if((result == 32'b00000000000000000000000000000000) & (zero == 1))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Logic Or Test #1
	alucontrol <= 3'b110; // Or
	a <= 32'b11111111111111111111111111111111;
	b <= 32'b11111111111111111111111111111111;
	#1;
	$display("Basic Logic Or Test #1");
	if((result == 32'b11111111111111111111111111111111) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Logic Or Test #2
	alucontrol <= 3'b110; // Or
	a <= 32'b00000000000000000000000000000000;
	b <= 32'b11111111111111111111111111111111;
	#1;
	$display("Basic Logic Or Test #2");
	if((result == 32'b11111111111111111111111111111111) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Logic Or Test #3
	alucontrol <= 3'b110; // Or
	a <= 32'b00000000000000000000000000000000;
	b <= 32'b00000000000000000000000000000000;
	#1;
	$display("Basic Logic Or Test #3");
	if((result == 32'b00000000000000000000000000000000) & (zero == 1))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Logic Or Test #4
	alucontrol <= 3'b110; // Or
	a <= 32'b01010101010101010101010101010101;
	b <= 32'b10101010101010101010101010101010;
	#1;
	$display("Basic Logic Or Test #4");
	if((result == 32'b11111111111111111111111111111111) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	// Basic Logic Or Test #5
	alucontrol <= 3'b110; // Or
	a <= 32'd5;
	b <= 32'd6;
	#1;
	$display("Basic Logic Or Test #5");
	if((result == 32'd7) & (zero == 0))
		$display("Correct");
	else
		$display("Wrong");
	#1;
	
	$finish;
end

endmodule
