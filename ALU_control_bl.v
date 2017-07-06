`timescale 1ns / 1ps
	module ALU_control_bl (
	inpFunction,
	ALUop1,
	ALUop2,
	ALUcontrol
	);
														//Added NOP to R-Type//
	parameter LW = 2'b00, SW = 2'b00, BranchNotZero = 2'b01, Rtype = 2'b10, Itype = 2'b11, add = 6'b100000, subtract = 6'b100010, NAND = 6'b001000, ARS = 6'b010000, NOP = 6'b111111;
	parameter add_c = 3'b010, subtract_c = 3'b110, NAND_c = 3'b000, ARS_c = 3'b001, NOP_c = 3'b111, bnz_c = 3'b011;
	input [5:0] inpFunction;
	input ALUop1;
	input ALUop2;
	
	wire [7:0] opt;
	
	output [2:0] ALUcontrol;
	
	assign opt = {ALUop2,ALUop1,inpFunction};
	
	assign ALUcontrol = (opt[7:6] == LW) ? (add_c) :
						(opt[7:6] == SW) ? (add_c) :
						(opt[7:6] == BranchNotZero) ? (bnz_c) :
						(opt[7:6] == Itype) ? (add_c) :
						(opt == {Rtype,add}) ? (add_c) :
						(opt == {Rtype,subtract}) ? (subtract_c) :
						(opt == {Rtype,NAND}) ? (NAND_c) :
						(opt == {Rtype,ARS}) ? (ARS_c) :
						(opt == {Rtype,NOP}) ? (NOP_c) : 3'bx;
	endmodule
	
						