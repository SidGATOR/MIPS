`timescale 1ns / 1ps
module ALU_32bit_bl (
//Control Signals//
	ALUcontrol,
//Input Data//
	in1,
	in2,
//Output Data//
	zero,
	out);
	
	parameter NAND = 3'b000, ARS = 3'b001, ADD = 3'b010, NOP = 3'b111, SUB =3'b110, BNZ = 3'b011;
	input [31:0] in1,in2;
	
	input [2:0] ALUcontrol;
	
	//input ALUop1;
	//input ALUop2;
	//input ALUsrc;
	//input [5:0] inpFunction;
	//wire [8:0] operation;
	output zero;
	output  [31:0] out;
//assign operation = {ALUsrc,ALUop2,ALUop1,inpFunction};
assign out = (ALUcontrol==NAND) ? ~(in1&in2) :
			 (ALUcontrol==ARS) ? (in1 >>> in2) :
			 (ALUcontrol==ADD) ? (in1 + in2) : 
			 (ALUcontrol==SUB) ? (in1 - in2) :
			 (ALUcontrol==BNZ) ? 32'bx :
			 (ALUcontrol==NOP) ? 32'bx : 32'bx;
			 
assign zero = (in1!=32'b0) ? 1'b1 : 1'b0;
endmodule
		
					