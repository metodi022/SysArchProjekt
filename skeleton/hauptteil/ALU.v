module ALU(
  
  input [31:0] a,
  input [31:0] b,
  input [2:0] alucontrol,
  output reg [31:0] result,
  output reg zero);
  
  
  always @(a or b or alucontrol)
    begin
      case (alucontrol)
        3'b000:
          result = = (a < b ? 1 : 0);
        
        3'b001:
          result = a - b;
        
        3'b101:
          result = a + b;
        
        3'b110:
          result = a | b;
        
        3'b111:
          result = a & b;
      endcase
      
      if (result == 0)
      zero = 1;
      else
      zero = 0;
      
    end
        
  
endmodule
