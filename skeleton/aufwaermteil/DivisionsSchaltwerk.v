module Division(
  input start, clock,
  input [31:0] a,
  input [31:0] b,
  output [31:0] q,
  output [31:0] r
);
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