module ProcessorTestbench();

	reg clk;
	reg reset;

	integer i;
	reg [31:0] expectedRegContent [1:31];

	// Instanziere das zu testende Verilog-Modul
	Processor proc(clk, reset);

	initial
		begin
			// Generiere eine Waveform-Ausgabe mit allen (nicht-Speicher) Variablen
			$dumpfile("simres.vcd");
			$dumpvars(0, ProcessorTestbench);

			/* initialize actual and expected registers to 0xcafebabe */
			for(i=1; i<32; i=i+1) begin
				proc.mips.dp.gpr.registers[i] = 32'hcafebabe;
				expectedRegContent[i] = 32'hcafebabe;
			end

			// Lese auszuführendes Programm ein
//			$readmemh("TestProgramme/Fibonacci.dat", proc.imem.INSTRROM, 0, 5); //Benötigt: Aufgabe 1.3
//			$readmemh("TestProgramme/Fibonacci.expected", expectedRegContent);
//			$readmemh("TestProgramme/Funktionsaufruf.dat", proc.imem.INSTRROM, 0, 4); //Benötigt: Aufgabe 1.7
//			$readmemh("TestProgramme/Funktionsaufruf.expected", expectedRegContent);
//			$readmemh("TestProgramme/Konstanten.dat", proc.imem.INSTRROM, 0, 2); //Benötigt: Aufgabe 1.4
//			$readmemh("TestProgramme/Konstanten.expected", expectedRegContent);
//			$readmemh("TestProgramme/Multiplikation.dat", proc.imem.INSTRROM, 0, 4); //Benötigt: Aufgabe 1.6
//			$readmemh("TestProgramme/Multiplikation.expected", expectedRegContent);

			// Unsere Testprogramme
            
            $readmemh("TestProgramme/mips1.dat", proc.imem.INSTRROM, 0, 1);
            //$readmemh("TestProgramme/MULTU-MFHI-big.expected", expectedRegContent);
            /*
            $readmemh("MULTU-MFLO-big.dat", proc.imem.INSTRROM, 0, 3);
            $readmemh("MULTU-MFLO-big.expected", proc.imem.INSTRROM, 0, 3);
            $readmemh("MULTU-MFHI-small.expected", proc.imem.INSTRROM, 0, 3);
            $readmemh("MULTU-MFLO-small.dat", proc.imem.INSTRROM, 0, 3);
            
            $readmemh("MULTU-MFHI-small.dat", proc.imem.INSTRROM, 0, 3);
            $readmemh("MULTU-MFLO-small.expected", proc.imem.INSTRROM, 0, 3);
            */
            
//			$readmemh("TestProgramme/Konstanten2.dat", proc.imem.INSTRROM, 0, 3); //Benötigt: Aufgabe 1.4
//			$readmemh("TestProgramme/Konstanten2.expected", expectedRegContent);			
//			$readmemh("TestProgramme/Konstanten3.dat", proc.imem.INSTRROM, 0, 4); //Benötigt: Aufgabe 1.4
//			$readmemh("TestProgramme/Konstanten3.expected", expectedRegContent);
//			$readmemh("TestProgramme/Konstanten4.dat", proc.imem.INSTRROM, 0, 2); //Benötigt: Aufgabe 1.4
//			$readmemh("TestProgramme/Konstanten4.expected", expectedRegContent);
//			$readmemh("TestProgramme/Konstanten5.dat", proc.imem.INSTRROM, 0, 2); //Benötigt: Aufgabe 1.4
//			$readmemh("TestProgramme/Konstanten5.expected", expectedRegContent);
//			$readmemh("TestProgramme/BLTZ.dat", proc.imem.INSTRROM, 0, 3); //Benötigt: Aufgabe 1.5
//			$readmemh("TestProgramme/BLTZ.expected", expectedRegContent);
//			$readmemh("TestProgramme/BLTZ2.dat", proc.imem.INSTRROM, 0, 4); //Benötigt: Aufgabe 1.5
//			$readmemh("TestProgramme/BLTZ2.expected", expectedRegContent);
//			$readmemh("TestProgramme/BLTZ3.dat", proc.imem.INSTRROM, 0, 4); //Benötigt: Aufgabe 1.5
//			$readmemh("TestProgramme/BLTZ3.expected", expectedRegContent);
//			$readmemh("TestProgramme/BLTZ4.dat", proc.imem.INSTRROM, 0, 5); //Benötigt: Aufgabe 1.5
//			$readmemh("TestProgramme/BLTZ4.expected", expectedRegContent);
//			$readmemh("TestProgramme/JAL1.dat", proc.imem.INSTRROM, 0, 3); //Benötigt: Aufgabe 1.7
//			$readmemh("TestProgramme/JAL1.expected", expectedRegContent);
//			$readmemh("TestProgramme/JAL2.dat", proc.imem.INSTRROM, 0, 3); //Benötigt: Aufgabe 1.7
//			$readmemh("TestProgramme/JAL2.expected", expectedRegContent);
//			$readmemh("TestProgramme/JR1.dat", proc.imem.INSTRROM, 0, 4); //Benötigt: Aufgabe 1.7
//			$readmemh("TestProgramme/JR1.expected", expectedRegContent);
//      	$readmemh("TestProgramme/Multu1.dat", proc.imem.INSTRROM, 0, 6); //Benötigt: Aufgabe 1.6
//      	$readmemh("TestProgramme/Multu1.expected", expectedRegContent);
//          TODO add test path (asm, dat, expected)

			// Generiere reset-Eingabe
			reset <= 1;
			#5; reset <= 0;
			// Anzahl simulierter Zyklen
			#117; // Fibonacci
//			#20; // Funktionsaufruf
//			#16; // Konstanten
//			#24; // Multiplikation

			for(i=1; i<32; i=i+1) begin
				$display("Register %d = %h", i, proc.mips.dp.gpr.registers[i]);
			end
			for(i=1; i<32; i=i+1) begin
				if(^proc.mips.dp.gpr.registers[i] === 1'bx || proc.mips.dp.gpr.registers[i] != expectedRegContent[i]) begin
					$write("FAILED");
					$display(": register %d = %h, expected %h",i, proc.mips.dp.gpr.registers[i], expectedRegContent[i]);
					$finish;
				end
			end
			$display("PASSED");
			$finish;
		end

	// Generiere ein periodisches Clock-Signal
	always
		begin
			clk <= 1; #2; clk <= 0; #2;
		end

endmodule

