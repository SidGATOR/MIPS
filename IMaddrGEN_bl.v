`timescale 1ns / 1ps
module IMaddrGEN_bl (
		clk,
		RSTcount,
		validIN,
		EMPTY,
		STOP,
		addr,
		PCstart
		);
	
	
	input clk;
	input EMPTY;
	input STOP;
	input RSTcount;
	input validIN;
	
	reg [31:0] count;
	
	output [31:0] addr;
	output  PCstart;
	
	/* always@(negedge RSTcount,negedge EMPTY)
		if(!RSTcount | !EMPTY)
			begin 
				count <=0;
			end */
	always@(posedge clk,posedge RSTcount)
		begin
			if(RSTcount)
				begin
					if(EMPTY && !(validIN))
					count = 0;
				end
			else
			begin
		case({validIN,EMPTY,STOP})
			{1'b1,1'b0,1'b0}    :	begin
									count = count + 1;
									end
			{1'b1, 1'b1, 1'b1}  :   begin
									count = count + 1;
									end
			default 			:	begin
									count = count;
									end
		endcase
		end
		end
	assign PCstart = (count) ? 1'b1 : 1'b0;	
	assign addr = count;

endmodule