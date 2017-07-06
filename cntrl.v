`timescale 1ns / 1ps

module cntrl(

    input  [5:0]	 ins,			
    output	reg	 regwr,		
    output	reg 	 memreg,		
    output 	reg	 br,			
    output	reg	 memwr,
    output	reg	 memrd,
    output	reg	 aluop1,
    output	reg	 aluop2,
    output	reg	 alusrc,
    output	reg	 regdst
	 
	 );
	parameter AndNandArs = 6'b000001, ADDI = 6'b101100, LOAD = 6'b100011, STORE = 6'b101011, BNZ = 6'b000111, NOP = 6'b111111;
	always@(*)
	begin
			case (ins) 
						
						// instructions : [ADD] [NAND] [ARS]
						AndNandArs : begin
											 regwr	 =	1;	
											 memreg	 =	0;
											 br		 = 0;
											 memwr	 = 0;
											 memrd	 = 0;
											 aluop1   = 0;
											 aluop2   = 1;
											 alusrc   = 0;
											 regdst   = 1;
										 end
						
						// instructions : [ADDI]
						ADDI : begin
											 regwr	 =	1;	
											 memreg	 =	0;
											 br		 = 0;
											 memwr	 = 0;
											 memrd	 = 0;
											 aluop1   = 1;
											 aluop2   = 1;
											 alusrc   = 1;
											 regdst   = 0;
										 end 
									
						// instructions : [LOAD]
						LOAD : begin
											 regwr	 =	1;	
											 memreg	 =	1;
											 br		 = 0;
											 memwr	 = 0;
											 memrd	 = 1;
											 aluop1   = 0;
											 aluop2   = 0;
											 alusrc   = 1; //Error change to 1
											 regdst   = 0;
										 end

						// instructions : [STORE]
						STORE : begin
											 regwr	 =	0;	
											 memreg	 =	0;
											 br		 = 0;
											 memwr	 = 1;
											 memrd	 = 0;
											 aluop1   = 0;
											 aluop2   = 0;
											 alusrc   = 1; //Error change to 1
											 regdst   = 0;
										 end
										 
						// instructions : [BNZ]
						BNZ : begin
											 regwr	 =	0;	
											 memreg	 =	0;
											 br		 = 1;
											 memwr	 = 0;
											 memrd	 = 0;
											 aluop1   = 1;
											 aluop2   = 0;
											 alusrc   = 0;
											 regdst   = 0;
										 end
										 
						// instructions : [NOP] Added to R-Type
						NOP : begin
											 regwr	 =	0;
											 memreg	 =	0;
											 br		 = 0;
											 memwr	 = 0;
											 memrd	 = 0;
											 aluop1   = 0;
											 aluop2   = 1;
											 alusrc   = 0;
											 regdst   = 0;
										 end


							default : begin
											 regwr	 =	0;
											 memreg	 =	0;
											 br		 = 0;
											 memwr	 = 0;
											 memrd	 = 0;
											 aluop1   = 0;
											 aluop2   = 1;
											 alusrc   = 0;
											 regdst   = 0;
										 end
					
				endcase 
	end
	
endmodule
