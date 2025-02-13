module Datapath(
	input         clk, reset,
	input         memtoreg,
	input         dobranch,
	input         alusrcbimm,
	input  [4:0]  destreg,
	input         regwrite,
	input         jump,
	input  [2:0]  alucontrol,
	output        zero,
	output [31:0] pc,
	input  [31:0] instr,
	output [31:0] aluout,
	output [31:0] writedata,
	input  [31:0] readdata
);
	wire [31:0] pc;
	wire [31:0] signimm;
	wire [31:0] srca, srcb, srcbimm;
	wire [31:0] result;
	
	// Fetch: Reiche PC an Instruktionsspeicher weiter und update PC
	ProgramCounter pcenv(clk, reset, dobranch, signimm, jump, instr[25:0], instr[5:0], aluout, pc);

	// Execute:
	// (a) Wähle Operanden aus
	SignExtension se(instr[15:0], signimm);
	assign srcbimm = alusrcbimm ? (((instr[31:26]==6'b001001) | (instr[31:26]==6'b001101))  ? instr[15:0] : signimm) : srcb;
	// (b) Führe Berechnung in der ALU durch
	ArithmeticLogicUnit alu(srca, srcbimm, alucontrol, aluout, zero);
	// (c) Wähle richtiges Ergebnis aus
	assign result = (instr[31:26] == 6'b000011) ? (pc+4) : (memtoreg ? readdata : aluout);	// JAL
	
	// Memory: Datenwort das zur (möglichen) Speicherung an den Datenspeicher übertragen wird
	assign writedata = srcb;

	// Write-Back: Stelle Operanden bereit und schreibe das jeweilige Resultat zurück
	RegisterFile gpr(clk, regwrite, instr[25:21], instr[20:16],
				   destreg, result, instr[5:0], srca, srcb);
	
	
endmodule

module ProgramCounter(
	input         clk,
	input         reset,
	input         dobranch,
	input  [31:0] branchoffset,
	input         dojump,
	input  [25:0] jumptarget,
	input  [5:0] funct,
	input  [31:0] aluout,
	output [31:0] progcounter
);
	reg  [31:0] pc;
	wire [31:0] incpc, branchpc, nextpc;

	// Inkrementiere Befehlszähler um 4 (word-aligned)
	Adder pcinc(.a(pc), .b(32'b100), .cin(1'b0), .y(incpc));
	// Berechne mögliches (PC-relatives) Sprungziel
	Adder pcbranch(.a(incpc), .b({branchoffset[29:0], 2'b00}), .cin(1'b0), .y(branchpc));
	// Wähle den nächsten Wert des Befehlszählers aus
	assign nextpc = ((funct == 6'b001000) && (dojump)) ? aluout :											// JR
					dojump   ? {incpc[31:28], jumptarget, 2'b00} :
					dobranch ? branchpc :
							   incpc;

	// Der Befehlszähler ist ein Speicherbaustein
	always @(posedge clk)
	begin
		if (reset) begin // Initialisierung mit Adresse 0x00400000
			pc <= 'h00400000;
		end else begin
			pc <= nextpc;
		end
	end

	// Ausgabe
	assign progcounter = pc;

endmodule

module RegisterFile(
	input         clk,
	input         we3,
	input  [4:0]  ra1, ra2, wa3,
	input  [31:0] wd3,
	input  [5:0] funct,
	output [31:0] rd1, rd2
);
	reg [31:0] registers[31:0];
	reg [63:0] hilo;
    reg [31:0] aux;
	reg [7:0] count;
	
	wire start;
	wire [31:0] q;
	wire [31:0] r;
	wire [31:0] in1;
	wire [31:0] in2;
	
	Division divu(.start(start), .clock(clk), .a(in1), .b(in2), .q(q), .r(r));
	
	always @(posedge clk)
		begin
		if (we3) begin
			case(funct)
				6'b011001: hilo <= rd1 * rd2;
				6'b011011: count <= 7'b0100000;
				default: registers[wa3] <= wd3;
			endcase
		end
		if (count > 0)
			count--;
		end
	
	always @(negedge count)
		begin
		hilo[31:0] <= q;
		hilo[63:32] <= r;
		end

	always @*
	begin		
        case(funct)
            6'b010000: aux <= hilo[63:32];
            6'b010010: aux <= hilo[31:0];
            default: aux <= (ra1 != 0) ? registers[ra1] : 0;
        endcase
	end
	
	assign rd1 = aux;
	assign rd2 = (ra2 != 0) ? registers[ra2] : 0;
	assign start = (funct == 6'b011011);
	assign in1 = (funct == 6'b011011) ? rd1 : in1;
	assign in2 = (funct == 6'b011011) ? rd2 : in2;
	
endmodule

module Adder(
	input  [31:0] a, b,
	input         cin,
	output [31:0] y,
	output        cout
);
	assign {cout, y} = a + b + cin;
endmodule

module SignExtension(
	input  [15:0] a,
	output [31:0] y
);
	assign y = {{16{a[15]}}, a};
endmodule

module ArithmeticLogicUnit(
	input  [31:0] a, b,
	input  [2:0]  alucontrol,
	output [31:0] result,
	output        zero
);
    
  reg [31:0] ALU_result;
  reg ALU_zero;
  assign result = ALU_result;
  assign zero = ALU_zero;
  
	always @*
    begin
      case (alucontrol)
        3'b000:
          ALU_result = (a < b ? 1 : 0);		// SLTU
        
        3'b001:
          ALU_result = a - b;				// SUBU
          
        3'b010:     // BLTZ Branch on less than zero
          ALU_result = ($signed(a) >= $signed(b) ? 1 : 0);
        3'b101:
          ALU_result = a + b;				// ADDU
        3'b011:
		  ALU_result = b << 16;				// shift left: [15:0] -> [31:0]
        3'b110:
          ALU_result = a | b;
        
        3'b111:
          ALU_result = a & b;
		3'b100:
		  ALU_result = a * b;
      endcase
      
      if (ALU_result == 0)
		ALU_zero <= 1;
      else
		ALU_zero <= 0;
      
    end

endmodule
