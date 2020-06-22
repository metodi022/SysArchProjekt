module ArithmeticLogicModul(
    input [1:0] clock,
    input [2:0] alucontrol,
    input [31:0] SrcA,
    input [31:0] SrcB,
    output [31:0] result,
    output [1:0] zero
    // zero==1 genau dann wenn result==(0^32)
);

reg resultReg;
reg zeroReg;
reg tmp;

always @(posedge clock)
begin

    // 0^31 (<a> < <b> ? 1 : 0)
    if (alucontrol == 3'b000)
    begin
        if ($singed(SrcA) < $signed(SrcB))
        begin
            resultReg <= 32'b00000000000000000000000000000000;
            zeroReg <= 1'b0;
        end
        else
            resultReg <= 32'b00000000000000000000000000000001;
            zeroReg <= 1'b1;
    end



    // <a> − <b>
    if (alucontrol == 3'b001)
    begin
        tmp <= ($singed(SrcA) - $signed(SrcB));
        
        if (tmp == 32'b00000000000000000000000000000000)
        begin
            resultReg <= 32'b00000000000000000000000000000000;
            zeroReg <= 1'b0;
        end
        else
        begin
            resultReg <= tmp;
            zeroReg <= 1'b1;
        end
    end



    // <a> − <b>
    if (alucontrol == 3'b001)
    begin
        tmp <= ($singed(SrcA) + $signed(SrcB));
        
        if (tmp == 32'b00000000000000000000000000000000)
        begin
            resultReg <= 32'b00000000000000000000000000000000;
            zeroReg <= 1'b0;
        end
        else
        begin
            resultReg <= tmp;
            zeroReg <= 1'b1;
        end
    end



    // a | b
    if (alucontrol == 3'b110)
    begin
        if ((SrcA | SrcB) == 32'b00000000000000000000000000000000)
        begin
            resultReg <= 32'b00000000000000000000000000000000;
            zeroReg <= 1'b0;
        end
        else
        begin
            resultReg <= tmp;
            zeroReg <= 1'b1;
        end
    end



    // a & b
    if (alucontrol == 3'b110)
    begin
        if ((SrcA | SrcB) == 32'b00000000000000000000000000000000)
        begin
            resultReg <= 32'b00000000000000000000000000000000;
            zeroReg <= 1'b0;
        end
        else
        begin
            resultReg <= (SrcA | SrcB);
            zeroReg <= 1'b1;
        end
    end
end


assign result = resultReg;
assign zero = zeroReg;


endmodule
