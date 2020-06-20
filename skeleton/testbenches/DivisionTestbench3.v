module DivisionTestbench();

reg clk, s;
wire [31:0] result;
wire [31:0] result_r;

// instantiate device under test
Division divide(.clock(clk),.start(s),.a(32'd9),.b(32'd5),.q(result),.r(result_r));

// generate clock
always
begin
clk <= 1'b1; #2; clk <= 1'b0; #2;
end

// assign value and test it
initial
begin

$dumpfile("sim_division.vcd");
$dumpvars;

s <= 1'b1; #25;
s <= 1'b1; #50;
s <= 1'b0; #160;
s <= 1'b0; #50; 

#120;
if (result == 32'd1 && result_r == 32'd4)
$display("Division successful");
else
$display("Division failed");

$finish;
end

endmodule

