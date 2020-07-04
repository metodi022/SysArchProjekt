module ALUTestbench();

reg [31:0] a;
reg [31:0] b;
reg [2:0] aluctrl;
wire [31:0] res;
wire z;

ArithmeticLogicUnit alu(.a(a), .b(b), .alucontrol(aluctrl), .result(res), .zero(z));

initial
begin
$dumpfile("dump.vcd");
$dumpvars;

aluctrl <= 3'b000;
a <= 32'd12;
b <= 32'd25;
#1
$display("STRT: 3'b000 (a < b = 1)");
if ((res == 1) & (z == 0))
$display("SUCC: 3'b000 (a < b = 1)");
else
$display("FAIL: 3'b000 (a < b = 1)");
$display();


aluctrl <= 3'b000;
a <= 32'd52;
b <= 32'd25;
#1
$display("STRT: 3'b000 (a > b = 0)");
if ((res == 0) & (z == 1))
$display("SUCC: 3'b000 (a > b = 0)");
else
$display("FAIL: 3'b000 (a > b = 0)");
$display();


aluctrl <= 3'b000;
a <= 32'd25;
b <= 32'd25;
#1
$display("STRT: 3'b000 (a==b = 1)");
if ((res == 0) & (z == 1))
$display("SUCC: 3'b000 (a==b = 1)");
else
$display("FAIL: 3'b000 (a==b = 1)");
$display();
$display();

/////////////////////////////////////

aluctrl <= 3'b001;
a <= 32'd25;
b <= 32'd25;
#1
$display("STRT: 3'b000 (25-25 = 0)");
if ((res == 0) & (z == 1))
$display("SUCC: 3'b000 (25-25 = 0)");
else
$display("FAIL: 3'b000 (25-25 = 0)");
$display();


aluctrl <= 3'b001;
a <= 32'd15;
b <= 32'd25;
#1
$display("STRT: 3'b000 (15-25 = 4294967286)");
if ((res == 4294967286) & (z == 0))
$display("SUCC: 3'b000 (15-25 = 4294967286)");
else
$display("FAIL: 3'b000 (15-25 = 4294967286)");
$display();


aluctrl <= 3'b001;
a <= 32'd25;
b <= 32'd15;
#1
$display("STRT: 3'b000 (25-15 = 10)");
if ((res == 10) & (z == 0))
$display("SUCC: 3'b000 (25-15 = 10)");
else
$display("FAIL: 3'b000 (25-15 = 10)");
$display();
$display();

/////////////////////////////////////

aluctrl <= 3'b101;
a <= 32'd25;
b <= 32'd25;
#1
$display("STRT: 3'b000 (25+25 = 50)");
if ((res == 50) & (z == 0))
$display("SUCC: 3'b000 (25+25 = 50)");
else
$display("FAIL: 3'b000 (25+25 = 50)");
$display();


aluctrl <= 3'b101;
a <= 32'd0;
b <= 32'd25;
#1
$display("STRT: 3'b000 (0+25 = 25)");
if ((res == 25) & (z == 0))
$display("SUCC: 3'b000 (0+25 = 25)");
else
$display("FAIL: 3'b000 (0+25 = 25)");
$display();


aluctrl <= 3'b101;
a <= 32'd25;
b <= 32'd0;
#1
$display("STRT: 3'b000 (25+0 = 25)");
if ((res == 25) & (z == 0))
$display("SUCC: 3'b000 (25+0 = 25)");
else
$display("FAIL: 3'b000 (25+0 = 25)");
$display();
$display();

/////////////////////////////////////

aluctrl <= 3'b110;
a <= 32'd25;
b <= 32'd0;
#1
$display("STRT: 3'b000 (25 | 0 = 25)");
if ((res == 25) & (z == 0))
$display("SUCC: 3'b000 (25 | 0 = 25)");
else
$display("FAIL: 3'b000 (25 | 0 = 25)");
$display();


aluctrl <= 3'b110;
a <= 32'd0;
b <= 32'd25;
#1
$display("STRT: 3'b000 (0 | 25 = 25)");
if ((res == 25) & (z == 0))
$display("SUCC: 3'b000 (0 | 25 = 25)");
else
$display("FAIL: 3'b000 (0 | 25 = 25)");
$display();


aluctrl <= 3'b110;
a <= 32'd0;
b <= 32'd0;
#1
$display("STRT: 3'b000 (0 | 0 = 0)");
if ((res == 0) & (z == 1))
$display("SUCC: 3'b000 (0 | 0 = 0)");
else
$display("FAIL: 3'b000 (0 | 0 = 0)");
$display();


aluctrl <= 3'b110;
a <= 32'd23;
b <= 32'd23;
#1
$display("STRT: 3'b000 (23 | 23 = 0)");
if ((res == 23) & (z == 0))
$display("SUCC: 3'b000 (23 | 23 = 0)");
else
$display("FAIL: 3'b000 (23 | 23 = 0)");
$display();
$display();

/////////////////////////////////////

aluctrl <= 3'b111;
a <= 32'd25;
b <= 32'd0;
#1
$display("STRT: 3'b000 (25 & 0 = 0)");
if ((res == 0) & (z == 1))
$display("SUCC: 3'b000 (25 & 0 = 0)");
else
$display("FAIL: 3'b000 (25 & 0 = 0)");
$display();


aluctrl <= 3'b111;
a <= 32'd0;
b <= 32'd25;
#1
$display("STRT: 3'b000 (0 & 25 = 0)");
if ((res == 0) & (z == 1))
$display("SUCC: 3'b000 (0 & 25 = 0)");
else
$display("FAIL: 3'b000 (0 & 25 = 0)");
$display();


aluctrl <= 3'b111;
a <= 32'd25;
b <= 32'd25;
#1
$display("STRT: 3'b000 (25 & 25 = 25)");
if ((res == 25) & (z == 0))
$display("SUCC: 3'b000 (25 & 25 = 25)");
else
$display("FAIL: 3'b000 (25 & 25 = 25)");
$display();


aluctrl <= 3'b111;
a <= 32'd0;
b <= 32'd0;
#1
$display("STRT: 3'b000 (0 & 0 = 0)");
if ((res == 0) & (z == 1))
$display("SUCC: 3'b000 (0 & 0 = 0)");
else
$display("FAIL: 3'b000 (0 & 0 = 0)");

end
endmodule
