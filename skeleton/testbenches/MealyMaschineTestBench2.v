module MealyPatternTestbench(); //testbench has no inputs, outputs and clock, a will be assigned in initial block
reg clk; //clock
reg val_a; //test value
  
  // instantiate device under test
  wire [1:0] result;
  MealyPattern mealy(.clock(clk), .i(val_a), .o(result));

// generate clock
always
begin 
clk <= 1'b1; #1; clk <= 1'b0; #1;
end

// assign value and test it
initial 
begin

$dumpfile("TestMealy.vcd");
$dumpvars;

val_a <= 1'b1; #1;
if (result == 2'b10) $display ("Correct");

val_a <= 1'b1; #2;
if (result == 2'b10) $display ("Wrong");

val_a <= 1'b1; #2;
if (result == 2'b10) $display ("Correct");

val_a <= 1'b0; #2;
if (result == 2'b10) $display ("Wrong");

val_a <= 1'b0; #2;
if (result == 2'b10) $display ("Wrong");

val_a <= 1'b1; #2;
if (result == 2'b10) $display ("Correct");

val_a <= 1'b1; #2;
if (result == 2'b10) $display ("Wrong");

val_a <= 1'b0; #2;
if (result == 2'b10) $display ("Wrong");

val_a <= 1'b0; #2;
if (result == 2'b10) $display ("Wrong");

val_a <= 1'b1; #2;
if (result == 2'b10) $display ("Correct");


$finish;
end
endmodule
