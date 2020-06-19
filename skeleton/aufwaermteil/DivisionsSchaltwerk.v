module Division(
	input         clock,
	input         start,
	input  [31:0] a,
	input  [31:0] b,
	output [31:0] q,
	output [31:0] r
);
    
    reg count;
    reg [31:0] currentR;        // first register
    reg [31:0] currentB;        // second register
    reg [31:0] doneRemaining    // speichert noch benötigte Bits v. Dividend A und bereits berechnete
                                // Bits v. Quotient Q  =>  {Q[N − 1 : i + 1], A[i : 0]} vor jeder Iteration
    
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
            
            // TODO Implementierung
            /*  R = 0
                for i = N-1 to 0
                    R’ = 2 * R + A[i]
                    if (R’ < B) then Q[i] = 0, R = R’
                    else Q[i] = 1, R = R’-B
            */
            
        end
           
           
	
	
	
	
	
	
	
	always
	begin
        clock <= 1'b1; #1; clock <= 1'b0; #1;
    end
	
	
endmodule

