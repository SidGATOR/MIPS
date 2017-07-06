`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:09:53 03/17/2016 
// Design Name: 
// Module Name:    top_mod 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_mod(input clkHI, input clkLOW, input rst, input validIN,input [31:0] wrData, output [31:0] out,
output [31:0] nextpc, output [31:0] muxpc0, output [31:0] instout, output [31:0] instinid,
output [31:0] pcad, output [31:0] npcoifid, output [4:0] ir5bitmemwb,
output [31:0] wbd, output [31:0] rd1out, output [31:0] rd2out, output [31:0] signextout,
output [31:0] npcoidex, output [31:0] r1inex, output [31:0] r2inex, output [31:0] signinex,
output [4:0] ins2016ex, output [4:0] ins1511ex, output [31:0] addoutex, output[2:0] aluctrl,
output [31:0] inpalu2,output [31:0] aluout, output [4:0] wrregaddout, output [31:0] npcoexmem,
output [31:0] reg2inmem, output [4:0] wregaddinmem, output [31:0] aluoutinmem, output [31:0]rddatout,
output [31:0] rddatinwb, output [31:0] aluoutinwb, output regwro, output memrego, output bro,
output memwro, output memrdo, output aluop1o, output aluop2o, output alusrco, output regdsto,
output memwrinmem,output memrdinmem,output VALIDout,output FULL, output AFULL
);
reg [31:0] k = 32'b1;

//Wires//
wire stop;
wire EMPTY;
wire RSTcount;
wire [32:0] wireRDdata;
wire PCstart;
wire [31:0]mux_alu_1;
wire [31:0]mux_alu_2;
wire [2:0]h1_ctrl_s1;
wire [2:0]h1_ctrl_s2;
wire wireRSTcount;
wire [31:0] wireRNT;
wire pcsrcexmem;
//1st stage
/* TOPfifoIM_bl TOPIM1(
	.clkHI(clkHI),
	.clkLOW(clkLOW),
	.rst(rst),
	.validIN(validIN),
	.wrData(wrData),
	.BAddr(npcoexmem),
	.PCsrc(pcsrcexmem),
	.nxtPC(muxpc0),
	.FULL(FULL), //optional//
	.AFULL(AFULL), //optional//
	.rdData(instout)
	); */
/* PC z1(.clk(clk), .rst(rst), .din(nextpc), .dout(pcad));

add_basic z2(.inp1(pcad),.inp2(k), .outp(muxpc0));

Mux z3(.inp1(muxpc0), .inp2(npcoexmem), .sel(pcsrcexmem), .outp(nextpc));

Inst_mem z4(.addr(pcad), .inst(instout)); */

assign PCenb = ((!stop) & PCstart) ? 1'b1 : 
				(pcsrcexmem) ? 1'b1 : 
				(wireRNT>pcad) ? 1'b1:1'b0;
assign wireRSTcount = RSTcount | pcsrcexmem;
	FIFO32_bl FIFO1(
		.clkHI(clkHI),
		.clkLOW(clkLOW),
		.rst(rst),
		.stop(stop), //Internal Signal//
		.validIN(validIN),
		.wrData(wrData),
		.FULL(FULL), 
		.AFULL(AFULL),
		.EMPTY(EMPTY), //Internal Signal//
		.RSTcount(RSTcount), //Internal Signal//
		.rdData(wireRDdata) //Internal Signal//
		);
IMtop_bl z4(
		.clk(clkHI),
		.RSTcount(RSTcount), //Internal Signal//
		.EMPTY(EMPTY), //Internal Signal//
		.PCstart(PCstart), //Internal Signal//
		.VALIDout(VALIDout),
		.VALIDin(wireRDdata[32]), //Internal Signal//
		.WRdata(wireRDdata), //Internal Signal//
		.RDaddr(pcad), 
		.RDdata(instout),
		.STOP(stop) //Internal Signal//
		);
PC z1(
		.clk(clkHI),
		.rst(rst),
		.din(nextpc),
		.dout(pcad)
	);
	Mux z3(
		.inp1(muxpc0),
		.inp2(npcoexmem),
		.sel(pcsrcexmem),
		.outp(nextpc)
	);
	
	add_basic_pc z2(
		.enb(PCenb),
		.inp1(pcad),
		.inp2(k),
		.outp(muxpc0)
		);
Buf_IFID z5(.clk(clkHI),.rst(rst), .npc(muxpc0), .instin(instout), .npco(npcoifid), .instout(instinid));

PC regRNT(
	.clk(clkHI),
	.rst(rst),
	.din(muxpc0),
	.dout(wireRNT)
	);




//2nd stage
cntrl z6(.ins(instinid[31:26]), .regwr(regwro), .memreg(memrego), .br(bro), .memwr(memwro), .memrd(memrdo), .aluop1(aluop1o),
.aluop2(aluop2o), .alusrc(alusrco), .regdst(regdsto));
  
reg_mem z7(.clk(clkHI), .rst(rst), .regwrite(regwrmemwb), .rs1(instinid[25:21]), .rs2(instinid[20:16]),
.wra(ir5bitmemwb), .wd(wbd), .rd1(rd1out), .rd2(rd2out));

sign_ext z8(.inp1(instinid[15:0]), .outp(signextout));

buf_IDEX z9(.clk(clkHI),.rst(rst), .regwr(regwro), .memreg(memrego), .memwr(memwro), .memrd(memrdo), .br(bro),.aluop1(aluop1o),
.aluop2(aluop2o), .alusrc(alusrco), .regdst(regdsto),.regwro(regwrinex), .memrego(memreginex), .memwro(memwrinex), .memrdo(memrdinex),
.bro(brinex),.aluop1o(aluop1inex), .aluop2o(aluop2inex), .alusrco(alusrcinex), .regdsto(regdstinex), .npc(npcoifid), .reg1(rd1out),
.reg2(rd2out), .signext(signextout), .inst2016(instinid[20:16]), .inst1511(instinid[15:11]),.npco(npcoidex), .reg1o(r1inex),
.reg2o(r2inex), .signexto(signinex), .inst2016o(ins2016ex), .inst1511o(ins1511ex));



//3rd stage
add_basic z10(.inp1(npcoidex),.inp2(signinex), .outp(addoutex));

Mux z11(.inp1(r2inex), .inp2(signinex), .sel(alusrcinex), .outp(inpalu2));

ALU_32bit_bl z12(.ALUcontrol(aluctrl),.in1(mux_alu_2),.in2(mux_alu_1),.out(aluout),.zero(zroalu));
	
ALU_control_bl z13(.inpFunction(signinex[5:0]),.ALUop1(aluop1inex),.ALUop2(aluop2inex),.ALUcontrol(aluctrl));
	
mux5bit z14(.inp1(ins2016ex), .inp2(ins1511ex), .sel(regdstinex), .outp(wrregaddout));

buf_EXMEM z15(.clk(clkHI),.rst(rst), .regwr(regwrinex), .memreg(memreginex), .memwr(memwrinex), .memrd(memrdinex), .br(brinex), .zr(zroalu),
.regwro(regwrinmem), .memrego(memreginmem),.memwro(memwrinmem), .memrdo(memrdinmem),.bro(brinmem), .zro(zraluinmem), .npc(addoutex),
.aluout(aluout), .reg2(r2inex), .ir5bit(wrregaddout), .npco(npcoexmem), .aluouto(aluoutinmem),.reg2o(reg2inmem), .ir5bito(wregaddinmem));



//4th stage
anded z16(.a(brinmem), .b(zraluinmem), .c(pcsrcexmem));

//Data_mem z17( .clk(clk), .addr(aluoutinmem), .din(reg2inmem), .dout(rddatout), .dmem_r(memrdinmem), .dmem_w(memwrinmem));

ram_bl z17(	.clk(clkHI),.wen(memwrinmem),.waddr(aluoutinmem),.wdata(reg2inmem),.raddr(aluoutinmem),.ren(memrdinmem), .rdata(rddatout));

buf_MEMWB z18(.clk(clkHI),.rst(rst), .regwr(regwrinmem), .memreg(memreginmem),.regwro(regwrmemwb), .memrego(memregsel),
	.rddata(rddatout), .rddatao(rddatinwb), .rdalu(aluoutinmem), .rdaluo(aluoutinwb),
	.ir5bit(wregaddinmem), .ir5bito(ir5bitmemwb));


//5th stage
Mux z19(.inp1(aluoutinwb), .inp2(rddatinwb), .sel(memregsel), .outp(wbd));

assign out = wbd;

hazard_detection h1( clkHI, instout, h1_ctrl_s2, h1_ctrl_s1);

mux8to1 m2(r1inex,aluoutinmem,aluoutinwb,'b0,'b0,'b0,'b0,'b0,h1_ctrl_s2,mux_alu_2);

mux8to1 m1(inpalu2,aluoutinmem,aluoutinwb,'b0,'b0,'b0,'b0,'b0,h1_ctrl_s1,mux_alu_1);

endmodule
