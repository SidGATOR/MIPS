`timescale 1ns / 1ps
module ram_bl (
	//Clock//
	clk,
	//Write//
	wen,
	waddr,
	wdata,
	//Read//
	ren, //Can comment it for Data memory//
	raddr,
	rdata
	);
	//Can change the num_word parameter to increase the depth of the ram//
	parameter num_word = 1024 , word_width = 32, addr_width = 32;
	
	input clk;
	//Write//
	input wen;
	input ren;
	input [addr_width-1:0] waddr;
	input [word_width-1:0] wdata;
	//Read//
	input [addr_width-1:0] raddr;
	output wire [word_width-1:0] rdata;	
	//Memory//
	reg [word_width-1:0] mem [num_word-1:0];
	reg [31:0] reg_rdata;
	
	/*This design will have blocking assignment to memory, allowing us to use the most recent value in the same clock cycle*/
	//Parameters//
	parameter opsRead = 2'b01, opsWrite = 2'b10, opsReadWrite = 2'b11;
	always@(posedge clk)
		begin
			case({wen,ren})
			opsRead :	 begin
							reg_rdata = mem[raddr];
						 end
			opsWrite : 	 begin
							mem[waddr] = wdata;
						 end
			opsReadWrite : begin
							mem[waddr] = wdata;
							reg_rdata = mem[raddr];
							end
			default : 	 begin
							reg_rdata = 32'bx;
						 end
			endcase
		end
	assign rdata = reg_rdata;
	//Returns Asynch Read.Cannot read the most recent data in the same cycle even though simulation will show the most recent output. Can potentially lead to race condition.//
	
	/* always@(posedge clk)
		begin
			if(wen)
				begin
					mem[waddr] = wdata;
				end
		end
	assign rdata = mem[raddr]; */
			
			
	//Read has a cycle delay for most recent value//
	
	/* always@(posedge clk)
		begin
			if(wen)
				begin
					mem[waddr]<=wdata;
				end
			else
				begin
					reg_rdata <= mem[raddr];
				end
		end
		assign rdata = reg_rdata; */
			
	
	endmodule