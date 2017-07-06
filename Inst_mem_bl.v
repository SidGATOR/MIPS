`timescale 1ns / 1ps
module Inst_mem_bl	(
	clk,
	WRaddr,
	WRdata,
	PCstart,
	EMPTY,
	VALIDin,
	RDaddr,
	RDdata,
	VALIDout,
	STOP
	);
	
	parameter num_word = 16, NOTempty = 2'b01, NOTvalid = 1'b0, FIFOempty = 1'b1, valid = 1'b1, NOOP = 32'b111111_00000_00000_00000_00000_111111;
	
	input [31:0] WRaddr;
	input [32:0] WRdata;
	input [31:0] RDaddr;
	input PCstart;
	input EMPTY;
	input VALIDin;
	input clk;
	
	output  reg [31:0] RDdata;
	//output [31:0] RDdata;
	output STOP;
	output VALIDout;
	
	reg [31:0] regRDdata;
	//reg [31:0] NOOPreg;
	reg [32:0] memory [0:num_word-1];
	
	wire wireStopLogic;
	wire wireStartWrite;
	
	assign VALIDout = memory[RDaddr] [32];
	assign wireStopLogic = (RDaddr + 1 > WRaddr && PCstart == 1);
	assign wireStartWrite = (RDaddr + 1> WRaddr && EMPTY == 0 ) ? 1'b1 : 1'b0;
	assign STOP = (!wireStartWrite && wireStopLogic) ? 1'b1 : 1'b0;
	always@(negedge clk)
		begin
		if(WRaddr >= RDaddr)
		case({EMPTY,WRdata[32]})
			NOTempty : 		begin
								memory[WRaddr] <= WRdata;
								/* if(PCstart == 1'b1)
									regRDdata <= memory[RDaddr];
								else
									regRDdata <= regRDdata; */
							end
			{1'b1,valid}:   begin
								memory[WRaddr] <= WRdata;
								if(RDaddr+1 > WRaddr && PCstart == 1)
									begin
										memory[WRaddr] <= memory[WRaddr];
									end
								/*else
									memory[WRaddr] <= WRdata; */
							end
							
			/* {1'bx,NOTvalid} : 	begin
									regRDdata <= NOOP;
								end
			{FIFOempty,1'bx} :	begin
									regRDdata <= NOOP;
								end
								
			{1'bx, valid} : begin
								regRDdata <= memory[RDaddr];
							end */
			default :  begin
						memory[WRaddr] <= memory[WRaddr];
						end
		endcase
		/* else
			begin
			if(!EMPTY)
				begin
				memory[WRaddr] <= WRdata;
				end
			else
				memory[WRaddr] <= memory[WRaddr];
			end */
		end
	always@(posedge clk)
		begin
			if(WRaddr >= RDaddr)
				begin
					if(PCstart && memory[RDaddr][32]==1)
						RDdata <= memory[RDaddr][31:0];
					else
						RDdata <= RDdata;
				end
			else
				RDdata <= NOOP;
				/* if(PCstart)
					begin
					regRDdata <= regRDdata;
					end
				else
					regRDdata <= NOOP; */
		end
	//assign RDdata = (WRaddr>=RDaddr) ? ((PCstart) ? memory[RDaddr][31:0]: RDdata) : NOOP;
		
endmodule