module MealyPattern(
    input        clock,
    input        i,
    output [1:0] o
);

    reg [2:0] q = 3'b000;
    reg [1:0] out = 2'b00;
    
    always @(posedge clock)
    
        begin
        
            q = q << 1;
            q[0] = i;
            
            if(q == 3'b001)
                out <= 2'b10;
            else
              if(q == 3'b111)
                out <= 2'b01;
              else
                out <= 2'b00;
            
        end
    
    assign o = out;
    
endmodule


module MealyPatternTestbench();
    
    //10b'1110011001
    reg clkTest, inTest;
    
    
    initial
    begin
        $dumpfile("MealyPattern.vcd");
        $dumpvars;
        
        inTest <= 1'b1; #1;
        $display("inTest==%h", inTest);
        if (outTest == 2'b10) $display ("CORRECT outputTest");
        
        inTest <= 1'b1; #2;
        $display("inTest==%h", inTest);
        if (outTest == 2'b10) $display ("WRONG outputTest");

        inTest <= 1'b1; #2;
        $display("inTest==%h", inTest);
        if (outTest == 2'b10) $display ("CORRECT outputTest");
            
        inTest <= 1'b0; #2;
        $display("inTest==%h", inTest);
        if (outTest == 2'b10) $display ("WRONG outputTest");

        inTest <= 1'b0; #2;
        $display("inTest==%h", inTest);
        if (outTest == 2'b10) $display ("WRONG outputTest");

        inTest <= 1'b1; #2;
        $display("inTest==%h", inTest);
        if (outTest == 2'b10) $display ("CORRECT outputTest");

        inTest <= 1'b1; #2;
        $display("inTest==%h", inTest);
        if (outTest == 2'b10) $display ("WRONG outputTest");

        inTest <= 1'b0; #2;
        $display("inTest==%h", inTest);
        if (outTest == 2'b10) $display ("WRONG outputTest");
        
        inTest <= 1'b0; #2;
        $display("inTest==%h", inTest);
        if (outTest == 2'b10) $display ("WRONG outputTest");

        inTest <= 1'b1; #2;
        $display("inTest==%h", inTest);
        if (outTest == 2'b10) $display ("CORRECT outputTest");

        
        $finish;
    end
    
    
    wire [1:0] outTest;
    MealyPattern machine(.clock(clkTest), .i(inTest), .o(outTest));
    
    
    
    always
    begin
        clkTest <= 1'b1; #1; clkTest <= 1'b0; #1;
    end

endmodule
