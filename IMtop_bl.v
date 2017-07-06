`timescale 1ns / 1ps
module IMtop_bl (
	clk,
	RSTcount,
	EMPTY,
	VALIDin,
	WRdata,
	RDaddr,
	STOP,
	PCstart,
	VALIDout,
	RDdata
	);
	
	input clk, RSTcount,EMPTY;
	input [32:0] WRdata;
	input [31:0] RDaddr;
	input VALIDin;
	
	
	output [31:0] RDdata;
	output STOP;
	output PCstart;
	output VALIDout;
	wire wirePCstart;
	
	wire wireSTOP;
	wire [31:0] WRaddr;
	wire VALIDout;
	
	reg regVALIDin;
	
	/* always@(posedge clk)
		begin
		 regVALIDin <= VALIDin;
		end */
	Inst_mem_bl IM1(
		.clk(clk),
		.WRaddr(WRaddr),
		.WRdata(WRdata),
		.EMPTY(EMPTY),
		.VALIDin(VALIDin),
		.PCstart(wirePCstart),
		.RDaddr(RDaddr),
		.RDdata(RDdata),
		.VALIDout(VALIDout),
		.STOP(wireSTOP)
		);
	IMaddrGEN_bl CNT1(
		.clk(clk),
		.RSTcount(RSTcount),
		.validIN(VALIDin),
		.EMPTY(EMPTY),
		.STOP(wireSTOP),
		.addr(WRaddr),
		.PCstart(wirePCstart)
		);
	assign STOP = wireSTOP;
	assign PCstart = wirePCstart;
endmodule