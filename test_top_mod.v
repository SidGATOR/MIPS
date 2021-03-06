`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:06:00 03/27/2016
// Design Name:   top_mod
// Module Name:   C:/Users/SOHAM/Desktop/xilinx/AVLSI/test_top_mod.v
// Project Name:  AVLSI
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_mod
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_top_mod;

	// Inputs
	reg clkHI;
	reg rst;
	reg clkLOW;
	reg validIN;
	reg [31:0] wrData;
	

	// Outputs
	wire FULL,AFULL;
	wire [31:0] out;
	wire [31:0] nextpc;
	wire [31:0] muxpc0;
	wire [31:0] instout;
	wire [31:0] instinid;
	wire [31:0] pcad;
	wire [31:0] npcoifid;
	wire [4:0] ir5bitmemwb;
	wire [31:0] wbd;
	wire [31:0] rd1out;
	wire [31:0] rd2out;
	wire [31:0] signextout;
	wire [31:0] npcoidex;
	wire [31:0] r1inex;
	wire [31:0] r2inex;
	wire [31:0] signinex;
	wire [4:0] ins2016ex;
	wire [4:0] ins1511ex;
	wire [31:0] addoutex;
	wire [2:0] aluctrl;
	wire [31:0] inpalu2;
	wire [31:0] aluout;
	wire [4:0] wrregaddout;
	wire [31:0] npcoexmem;
	wire [31:0] reg2inmem;
	wire [4:0] wregaddinmem;
	wire [31:0] aluoutinmem;
	wire [31:0] rddatout;
	wire [31:0] rddatinwb;
	wire [31:0] aluoutinwb;
	wire regwro;
	wire memrego;
	wire bro;
	wire memwro;
	wire memrdo;
	wire aluop1o;
	wire aluop2o; 
	wire alusrco;
	wire regdsto;
	wire memwrinmem;
	wire memrdinmem;
	wire VALIDout;
	
	parameter NOOP = 32'b111111_00000_00000_00000_00000_111111;
	// Instantiate the Unit Under Test (UUT)
	top_mod uut (
		.clkHI(clkHI),
		.clkLOW(clkLOW),
		.VALIDout(VALIDout),
		.FULL(FULL),
		.AFULL(AFULL),
		.wrData(wrData),
		.validIN(validIN),
		.rst(rst), 
		.out(out), 
		.nextpc(nextpc), 
		.muxpc0(muxpc0), 
		.instout(instout), 
		.instinid(instinid), 
		.pcad(pcad), 
		.npcoifid(npcoifid), 
		.ir5bitmemwb(ir5bitmemwb), 
		.wbd(wbd), 
		.rd1out(rd1out), 
		.rd2out(rd2out), 
		.signextout(signextout), 
		.npcoidex(npcoidex), 
		.r1inex(r1inex), 
		.r2inex(r2inex), 
		.signinex(signinex), 
		.ins2016ex(ins2016ex), 
		.ins1511ex(ins1511ex), 
		.addoutex(addoutex), 
		.aluctrl(aluctrl), 
		.inpalu2(inpalu2), 
		.aluout(aluout), 
		.wrregaddout(wrregaddout), 
		.npcoexmem(npcoexmem), 
		.reg2inmem(reg2inmem), 
		.wregaddinmem(wregaddinmem), 
		.aluoutinmem(aluoutinmem), 
		.rddatout(rddatout), 
		.rddatinwb(rddatinwb), 
		.aluoutinwb(aluoutinwb),
		.regwro(regwro),
		.memrego(memrego),
		.bro(bro),
		.memwro(memwro),
		.memrdo(memrdo),
		.aluop1o(aluop1o),
		.aluop2o(aluop2o), 
		.alusrco(alusrco),
		.regdsto(regdsto),
		.memwrinmem(memwrinmem),
		.memrdinmem(memrdinmem)
	);
always
	begin
		#5 clkHI = ~clkHI;
		//#5 clkLOW = ~clkLOW;
	end
always 
  begin
    #10 clkLOW = ~clkLOW;
end
	
	initial
		begin
			clkHI = 0; clkLOW = 0; rst = 1; validIN = 0; 
			#5 rst = 0;
			#40
			#3 rst = 1;
			#2 wrData = 32'b101100_11111_00001_0000000000000001; validIN = 1; //MVI,R(1),16BIT VALUE (R32 IS THE ALL ZERO REGISTER
			#20 wrData = 32'b101100_11111_00011_0000000000000010; //MVI R(3), 16BIT VALUE
			#20 wrData = 32'b101100_11111_00101_0000000000000011; //MVI R(5), 16BIT VALUE
			#20 wrData = 32'b101100_11111_00100_0000000000000011; //MVI R(4), 16BIT VALUE
			#20 wrData = 32'b101100_11111_01100_0000000000000000; //MVI R(6), 16BIT VALUE	
			#20 wrData = 32'b101011_00011_00011_0000000000001000; //SW mem[R[3]+OFFSET] = R[1}			
			#20 wrData = NOOP;
			#20 wrData = NOOP;
			#20 wrData = 32'b000111_00001_00011_0000000000000001; // BNZ
			#20 wrData = 32'b000001_00100_00011_00001_00000_100000;//ADD R(1), R(3), R(4)
			#20 wrData = 32'b000001_00001_00101_00010_00000_100000;//ADD R(2), R(5), R(1)
			#20 wrData = 32'b000001_00010_00001_00111_00000_100000;//ADD R(7), R(1), R(2)
			//#20 wrData = 32'b000001_00001_00011_00100_00000_001000; //NAND R(1), R(3), R(4)
			//#20 wrData = 32'b000001_00100_00101_00100_00000_100000; //ADD R(4), R(5), R(4)
            #20 wrData = NOOP;
			#20 wrData = NOOP;
			#20 wrData = 32'b100011_00011_00011_0000000000001000; //LW mem[R[3]+OFFSET] = R[1]
			//#20 wrData = 32'b000111_01100_00001_0000000000000001; // BNZ
			#20 wrData = NOOP;
			/*
			//#20
			//#20 wrData = 32'b000001_00001_00011_00100_00000_100000;
			#20 wrData = 32'b000001_00100_00001_00101_00000_100000;//ADD R(4), R(1), R(5)
			#20 wrData = 32'b000001_00001_00011_00010_00000_001000; //NAND R(1), R(3), R(2) I CHANGED THE R TYPE FUNCTION TO 000001, I GUESS :P CHECK
			#20 wrData = 32'b101011_00011_00001_0000000000001000; //SW mem[R[3]+OFFSET] = R[1}
			#20 wrData = 32'b100011_00011_01001_0000000000001000; //LW mem[R[3]+OFFSET] = R[9]
			#20 wrData = 32'b000111_00001_00011_0000000000000010;//BNZ I DIDNT CHECK.. YOU CHECK THE INST AND THE SIMULATION
			#20 wrData = 32'hFC00003F; 
			#20 wrData = 32'hFC00003F;
			#20 wrData = 32'h50505050; validIN =0;
			#20 wrData = 32'h95959595;
			#20 wrData = 32'hA0A0A0A0;
			/* #20 wrData = 32'hD7D7D7D7;
			#20 wrData = 32'hE9E9E9E9;
			#20 wrData = 32'hD5D5D5D5;
			#20 wrData = 32'h1F1F1F1F;
			#20
			#20
			#20
			#20
			#20
			#5 rst=0; 
			#20 
			#3 rst =1;
			#2 wrData = 32'b101011_00011_00001_0000000000001000; validIN = 1;//SW mem[R[3]+OFFSET] = R[1}
			#20 wrData = 32'b100011_00011_01001_0000000000001000; //LW mem[R[3]+OFFSET] = R[9]
			#20 wrData = 32'b000111_00011_01001_0000000000001000;//BNZ I DIDNT CHECK.. YOU CHECK THE INST AND THE SIMULATION
			#20	wrData = 32'b101100_11111_00001_1010101010101010; validIN = 1; //MVI,R(1),16BIT VALUE (R32 IS THE ALL ZERO REGISTER
			#20 wrData = 32'b101100_11111_00011_0000000000000010; //MVI R(3), 16BIT VALUE
			#20 wrData = 32'b000001_00001_00011_00010_00000_001000; //NAND R(1), R(3), R(2) I CHANGED THE R TYPE FUNCTION TO 000001, I GUESS :P CHECK
			#20 wrData = 32'hFC00003F; 
			#20 wrData = 32'hFC00003F;
			#20  validIN =0; */
			//#20 wrData = 32'hA1A1A1A1; BAddr = 3; PCsrc = 1;
			end
      
endmodule

