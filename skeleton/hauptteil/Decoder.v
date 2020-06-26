module Decoder(
	input     [31:0] instr,      // Instruktionswort
	input            zero,       // Liefert aktuelle Operation im Datenpfad 0 als Ergebnis?
	output reg       memtoreg,   // Verwende ein geladenes Wort anstatt des ALU-Ergebis als Resultat
	output reg       memwrite,   // Schreibe in den Datenspeicher
	output reg       dobranch,   // Führe einen relativen Sprung aus
	output reg       alusrcbimm, // Verwende den immediate-Wert als zweiten Operanden
	output reg [4:0] destreg,    // Nummer des (möglicherweise) zu schreibenden Zielregisters
	output reg       regwrite,   // Schreibe ein Zielregister
	output reg       dojump,     // Führe einen absoluten Sprung aus
	output reg [2:0] alucontrol  // ALU-Kontroll-Bits
);
	// Extrahiere primären und sekundären Operationcode
	wire [5:0] op = instr[31:26];
	wire [5:0] funct = instr[5:0];

	always @*
	begin
		case (op)
			6'b000000: // Rtype Instruktion
				begin
					regwrite = 1;
					destreg = instr[15:11];
					alusrcbimm = 0;
					dobranch = 0;
					memwrite = 0;
					memtoreg = 0;
					dojump = 0;
					case (funct)
						6'b100001: alucontrol = 3'b101;// TODO // Addition unsigned
						6'b100011: alucontrol = 3'b001;// TODO // Subtraktion unsigned
						6'b100100: alucontrol = 3'b111;// TODO // and
						6'b100101: alucontrol = 3'b110;// TODO // or
						6'b101011: alucontrol = 3'b000;// TODO // set-less-than unsigned
						6'b011001: alucontrol = 3'b100;// 		  MULTU
						default:   alucontrol = 3'b010;// TODO // BGTZ
					endcase
				end
            6'b000001: // BLTZ Branch on less than zero
                begin
                    regwrite = 0;                   // no
                    destreg = 5'bx;                 // Destination reg not fixed
                    alusrcbimm = 0;                 // 0
                    dobranch = zero;                   // depends on zero
                    memwrite = 0;                   // No memory write
                    memtoreg = 1'bx;                   // No memory to reg
                    dojump =  0;                    // no
                    alucontrol = 3'b010;            //
                end
			6'b100011, // Lade Datenwort aus Speicher
			6'b101011: // Speichere Datenwort
				begin
					regwrite = ~op[3];
					destreg = instr[20:16];
					alusrcbimm = 1;
					dobranch = 0;
					memwrite = op[3];
					memtoreg = 1;
					dojump = 0;
					alucontrol = 3'b101;// TODO // Addition effektive Adresse: Basisregister + Offset
				end
			6'b000100: // Branch Equal
				begin
					regwrite = 0;
					destreg = 5'bx;
					alusrcbimm = 0;
					dobranch = zero; // Gleichheitstest
					memwrite = 0;
					memtoreg = 0;
					dojump = 0;
					alucontrol = 3'b001;// TODO // Subtraktion
				end
			6'b001001: // Addition immediate unsigned
				begin
					regwrite = 1;
					destreg = instr[20:16];
					alusrcbimm = 1;
					dobranch = 0;
					memwrite = 0;
					memtoreg = 0;
					dojump = 0;
					alucontrol = 3'b101;// TODO // Addition
				end
			6'b000010: // Jump immediate
				begin
					regwrite = 0;
					destreg = 5'bx;
					alusrcbimm = 0;
					dobranch = 0;
					memwrite = 0;
					memtoreg = 0;
					dojump = 1;
					alucontrol = 3'b010;// TODO
				end
			6'b001111: // LUI
				begin
					regwrite = 1;											// Yes
					destreg = instr[20:16];									// Destination reg rt[20:16]
					alusrcbimm = 1; 										// Yes, immediate[15:0] extended
					dobranch = 0;  											// No branch
					memwrite = 0;   										// No memory write
					memtoreg = 0;  											// No memory to reg
					dojump = 0;     										// No jump
					alucontrol = 3'b011;									// ALU slt => ALUCode = 011
				end
			6'b001101: // ORI
				begin
					regwrite = 1;											// Yes
					destreg = instr[20:16];									// Destination reg rt[20:16]
					alusrcbimm = 1; 										// Yes, immediate[15:0] extended
					dobranch = 0;  											// No branch
					memwrite = 0;   										// No memory write
					memtoreg = 0;  											// No memory to reg
					dojump = 0;     										// No jump
					alucontrol = 3'b110;									// ALU or
				end
			default: // Default Fall
				begin
					regwrite = 1'bx;
					destreg = 5'bx;
					alusrcbimm = 1'bx;
					dobranch = 1'bx;
					memwrite = 1'bx;
					memtoreg = 1'bx;
					dojump = 1'bx;
					alucontrol = 3'b010;// TODO
				end
		endcase
	end
endmodule

