module DivisionTestbench();

reg clk, s;
wire [31:0] result;
wire [31:0] result_r;
reg [31:0] a;
reg [31:0] b;

// instantiate device under test
Division divide(.clock(clk),.start(s),.a(a),.b(b),.q(result),.r(result_r));

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

s <= 1'b1;
a <= 32'd20;
b <= 32'd10;
#1;
s <= 1'b0; #63;

if (result == 32'd2 && result_r == 32'd0)
$display("Division successful");
else
$display("Division failed");

s <= 1'b1;
a <= 32'd10;
b <= 32'd20;
#1; s <= 1'b0; #63;

if (result == 32'd0 && result_r == 32'd10)
$display("Division successful");
else
$display("Division failed");

$finish;
end

endmodule

