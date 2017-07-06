`timescale 1ns / 1ps
module DualFF (
	clkHI,
	clkLOW,
	rst,
	in,
	out
	);
	
	input in;
	input clkHI;
	input clkLOW;
	input rst;
	
	output reg out;
	
	reg reg_in1, reg_in2;
	
	always@(posedge clkHI,negedge rst)
		begin
			if(!rst)
				begin
					reg_in1 <= 0;

				end
			else
				begin
				reg_in1 <= in;
				end
		end
	always@(posedge clkLOW, negedge rst)
		begin
			if(!rst)
				begin
				 	reg_in2 <= 0;
					out <= 0;
				end
			else
				begin
					reg_in2 <= reg_in1;
					out <= reg_in2;
				end
		end
	endmodule