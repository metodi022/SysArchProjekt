module DivisionTestbench();

reg start, clllk;
integer divident = 0;
integer divisor = 0;
integer expectedQ = 0;
integer expectedR = 0;
integer succ = 0;
wire [31:0] quotient, remainder;

always
begin
    clllk <= 1'b1; #2; clllk <= 1'b0; #2;
end


Division olaf(.start(start), .clock(clllk), .a(divident), .b(divisor), .q(quotient), .r(remainder));

initial
begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    //even / even = x R 0;
    divident <= 32'd26;
    #1
    divisor <= 32'd2;
    #1
    expectedQ <= 32'd13;
    #1
    expectedR <= 32'd0;
    #1
    
    start <= 1'b1;
    #4;
    start <= 1'b0;
    #128    // #32*4 Takte warten nach Start    
    if((quotient==expectedQ) && (remainder==expectedR))
    begin
        succ <= succ+1;
        $display("test succeded: %d / %d = %d R %d", divident, divisor, quotient, remainder);
    end
    
    
    //even / odd  = x R 0;
    divident <= 32'd252;
    #1;
    divisor <= 32'd3;
    #1;
    expectedQ <= 32'd84;
    #1;
    expectedR <= 32'd0;
    #1;
    
    start <= 1'b1;
    #4;
    start <= 1'b0;
    #128    // #32*4 Takte warten nach Start
    if((quotient==expectedQ) && (remainder==expectedR))
    begin
        succ <= succ+1;
        $display("test succeded: %d / %d = %d R%d", divident, divisor, quotient, remainder);
    end
    
    
    //even / odd  = x R y;
    divident <= 32'd254;
    #1;
    divisor <= 32'd3;
    #1;
    expectedQ <= 32'd84;
    #1;
    expectedR <= 32'd2;
    #1;
    
    start <= 1'b1;
    #4;
    start <= 1'b0;
    #128    // #32*4 Takte warten nach Start
    
    if((quotient==expectedQ) && (remainder==expectedR))
    begin
        succ <= succ+1;
        $display("test succeded: %d / %d = %d R %d", divident, divisor, quotient, remainder);
    end
    
    
    #1;
    
    
    if(succ==32'd3)
    $display("SUCC: all %d tests successful", succ);
    else
    $display("FAIL: only %d tests succeeded", succ);
    
$finish;
end
endmodule

