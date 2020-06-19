module Division(
  input start, clock,
  input [31:0] a,
  input [31:0] b,
  output [31:0] q,
  output [31:0] r
);
<<<<<<< HEAD
  reg [31:0] currentR = 0;
  reg [31:0] helpR = 0;
  reg [31:0] currentQ;
  reg [6:0] count = 7'b0100000;

  always @(posedge clock)
    begin
    
      if(start)
        begin
            currentR <= 0;
            helpR <= 0;
            count = 7'b0100000;
        end
    
      if(count > 0)
        begin
            helpR = (2*currentR) + a[count-1];
           
            if(helpR < b)
            begin
                currentQ[count-1] <= 1'b0;
                currentR <= helpR;
            end
              else
                begin
                    currentQ[count-1] <= 1'b1;
                      currentR <= helpR - b;
                end
    
              count <= count-1;
        end
       end

  assign q = currentQ;
  assign r = currentR;
endmodule
=======
    
    reg count;
    reg [31:0] currentR;        // first register; speichert den aktuellen Wert des Rests R
    reg [31:0] currentB;        // second register; speichert den aktuellen Wert des Divisors B
    reg [31:0] doneRemaining    // speichert noch benötigte Bits v. Dividend A und bereits berechnete
                                // Bits v. Quotient Q  =>  {Q[31 : i + 1], A[i : 0]} vor jeder Iteration
    
    always @(posedge clock)
    begin
        if (start == 1)
        begin
            assign count <= 0;
            assign currentR <= 1'b0;
            assign currentB <= b;
            assign doneRemaining <= 32'b00000000000000000000000000000000;
        end
        
        
        if (count != 32)
        begin
            for (i = 31; i > 0; i --)
            begin
            
            /* assign currentR = 2 * r + A[i]; */
            
            if (currentR < currentB)
            begin
                /* Q[i] = 0; */
                r = currentR;
            end
            else
            begin
                /* Q[i] = 1; */
                assign r = currentR - currentB;
                
            end
        end
           
	
	always
	begin
        clock <= 1'b1; #1; clock <= 1'b0; #1;
    end
	
	
endmodule

//////////////////////////////////////////////////
//////////////////////////////////////////////////


module IndexAccess (
    input [31:0] in,
    input [31:0] k,
    input clock,
    output reg out
);

reg [31:0] tmp;
assign tmp = k;
reg [0:0] this;
assign this = tmp;

always @(posedge clock)
begin
    if (this == 1'b1)
        assign out = tmp;
    else
        assign tmp = tmp << 1;
end

endmodule


>>>>>>> 49b9a6fae46cc43b73102ebc128ed17e8af2b811
