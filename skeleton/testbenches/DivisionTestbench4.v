module DivisionTestbench();

reg clk, s;
wire [31:0] result;
wire [31:0] result_r;

// instantiate device under test
Division divide(.clock(clk),.start(s),.a(32'd5),.b(32'd9),.q(result),.r(result_r));

// generate clock
always
begin
clk <= 1'b1; #1; clk <= 1'b0; #1;
end

// assign value and test it
initial
begin

$dumpfile("sim_division.vcd");
$dumpvars;

s <= 1'b1; #1;
s <= 1'b0; #63;

#120;
if (result == 32'd0 && result_r == 32'd5)
$display("Division successful");
else
$display("Division failed");

$finish;
end

endmodule

