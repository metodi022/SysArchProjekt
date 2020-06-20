module DivisionTestbench();

reg clk, s;
wire [31:0] result;
wire [31:0] result_r;

// instantiate device under test
Division divide(.clock(clk),.start(s),.a(32'd7),.b(32'd3),.q(result),.r(result_r));

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

s <= 1'b0; #1; 
s <= 1'b1; #4; 
s <= 1'b1; #6;
s <= 1'b1; #10;
s <= 1'b0; #15;
s <= 1'b1; #25;
s <= 1'b1; #50;
s <= 1'b0; #160; 

#100;
if (result == 32'd2 && result_r == 32'd1)
$display("Division successful");
else
$display("Division failed");

$finish;
end

endmodule

