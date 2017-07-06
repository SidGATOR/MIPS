`timescale 1ns / 1ps
module FIFO32_bl (
	clkHI,
	clkLOW,
	rst,
	stop,
	validIN,
	wrData,
	FULL,
	AFULL,
	EMPTY,
	RSTcount,
	rdData
	);
	
	//parameter//
	parameter LASTword = 15, BEGIN = 0, SIZEbuf = 16, LEFT = 3, sizeTOP = 3, sizeBOTTOM = 3;
	
	//Reset//
	input rst;
	
	//Higher Clock Domain//
	input clkHI;
	input [31:0] wrData;
	input stop;
	output EMPTY;
	output RSTcount;
	
	//Lower Clock Domain//
	input clkLOW;
	input validIN;
	output FULL;
	output AFULL;
	output [32:0] rdData;
	
	//Buffer//
	reg [32:0] buffered [0:SIZEbuf-1];
	reg [sizeTOP:0] TOP;
	reg [sizeBOTTOM:0] BOTTOM;
	
	//Registers//
	reg RSTcount;
	reg FULL;
	reg AFULL;
	reg EMPTY;
	reg [32:0] rdData;
	reg [3:0] initBUFcnt;
	reg flag;
	reg flagRead;
	reg [31:0] captureReg;
	//Wire//
	
	wire wire_validIN;
	
	//Dual Flop for validIN//
	DualFF FF1(
		.clkHI(clkLOW),
		.clkLOW(clkHI),
		.rst(rst),
		.in(validIN),
		.out(wire_validIN)
		);

	//Pointer Logic//
	always@(posedge clkLOW,negedge rst)
		begin
			if(!rst)
				begin
					AFULL <= 0;
					FULL <= 0;
					EMPTY <= 1;
					RSTcount <= 1;
				end
			else
				begin
					FULL <= 0;
					EMPTY <= 0;
					RSTcount <= 0;
				case(TOP)
					BEGIN: 		begin
									EMPTY <= 1;
									AFULL <= 0;
								end
					BOTTOM: 	begin
									EMPTY <= 1;
									AFULL <= 0;
									//RSTcount <= 1;
								end
					LEFT:		begin
									AFULL <= 1;
								end
					LASTword:	 begin
									if(TOP != BOTTOM)
										begin
											FULL <= 1;
											AFULL <= 1;
											EMPTY <= 0;
										end
									else
										begin
											EMPTY <= 1;
											RSTcount <= 1;
											AFULL <= 0;
										end
								end
					default: 	begin
									FULL <= 0;
									EMPTY <= 0;
									AFULL <= 0;
								end
				endcase
				end	
		end
	//Counter for Pointer TOP//	
	always@(posedge clkLOW,negedge rst)
		begin
			if(!rst)
				begin
					TOP <= 0;
					initBUFcnt <= 0;
					flag <= 0;
				end
			else			
				if(TOP < SIZEbuf)
					begin
						case({validIN,AFULL})
							2'b10 : 	begin
											TOP <= TOP + 1;
											if(initBUFcnt == 7)
												begin
												flag <= 1;
												end
											else
												initBUFcnt <= initBUFcnt + 1;
										end
							2'b11 : 	begin
											TOP <= TOP + 1;
											if(initBUFcnt == 2)
												begin
												flag <= 1;
												end
											else
												initBUFcnt <= initBUFcnt + 1;
										end
							default : 	begin
											TOP <= TOP;
										end
						endcase
					
					end					
				else
					begin
					
					if (TOP == BOTTOM)
							begin
								if(validIN == 1 && TOP == LASTword + 1)
										begin
											TOP <= 1;
											flag <=0;
											initBUFcnt <= 0;
										end
								else
									TOP <= TOP;
							end
					else
						TOP <= TOP;
					end
		end
	//Counter for pointer BOTTOM//
	always@(posedge clkHI,negedge rst)
		begin
			if(!rst)
				BOTTOM <= 0;
			else
				if(TOP > 0)
					begin
						if(TOP == BOTTOM)
							begin
								/* if(wire_validIN && TOP == LASTword)
									BOTTOM <= 0;
								else */
									BOTTOM <= BOTTOM;
							end
						else
							begin
								if(wire_validIN && flag == 1 && stop == 0)
									BOTTOM <= BOTTOM + 1;
							end
					
				
					end		
				else
					begin
						BOTTOM <= 0;
					end
		end
	//Capture REgister//
	always@(posedge clkLOW)
		begin
			captureReg <= wrData;
		end
		
	//Data Write Logic//
	always@(posedge clkLOW)
		begin
			if(validIN == 1 && FULL != 1)
			begin
			if(flag==0 && TOP==1)
				begin
					buffered[0] <= {validIN,captureReg};
				end
			buffered[TOP] <= {validIN,wrData};
			end
			else
			buffered[TOP] <= buffered[TOP];
		end
	//Data Read Logic//	
	always@(posedge clkHI)
		begin
			if(flag == 1 && stop == 0 && buffered[BOTTOM][32] == 1'b1)
				if(TOP == BOTTOM && buffered[BOTTOM][32] == 1'b1)
					rdData <= wrData;
				else
					rdData <= buffered[BOTTOM];
			else
			rdData <= 32'b0;
		end
		
endmodule