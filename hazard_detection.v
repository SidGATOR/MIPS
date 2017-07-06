`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2016 09:17:48 PM
// Design Name: 
// Module Name: hazard_detection
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module hazard_detection(
    input clk,
    input [31:0] instr,
    output reg [2:0] h1_ctrl_s2,
    output reg [2:0] h1_ctrl_s1
    );
    
    reg [31:0]IF_RF;
    reg [31:0]RF_EX;
    reg [31:0]EX_MEM;
    reg [31:0]MEM_WB;
        
    always@(posedge clk)
    begin
        MEM_WB = EX_MEM;
        EX_MEM = RF_EX;
        RF_EX  = IF_RF;
        IF_RF  = instr;
    end 
    
    /*
    000 default
    001 add add / nand nand / addi addi
    010 add xxx add / nand xxx nand / addi xxx addi
    011 
    100 
    101
    110
    111
    */
  
  
     
    always@(*)
    begin

//===========================================================================================
//               check for s2 ADD ADD / ADD NAND / ADD ADDI
//                            NAND ADD / NAND NAND / NAND ADDI 
//                            ADDI ADD / ADDI NAND / ADDI ADDI  hazard
//===========================================================================================
        if (((EX_MEM[31:26] == 6'b00_0001) && 
            ((RF_EX[31:26] == 6'b00_0001)||(RF_EX[31:26] == 6'b00_0001) || (RF_EX[31:26] == 6'b10_1100))) ||
            ((EX_MEM[31:26] == 6'b00_0001) && 
            ((RF_EX[31:26] == 6'b00_0001)||(RF_EX[31:26] == 6'b00_0001) || (RF_EX[31:26] == 6'b10_1100))) ||
            ((EX_MEM[31:26] == 6'b10_1100) && 
            ((RF_EX[31:26] == 6'b00_0001)||(RF_EX[31:26] == 6'b00_0001) || (RF_EX[31:26] == 6'b10_1100))))
  
        begin
        
        // check 2nd operand
            if (EX_MEM[15:11] == RF_EX[25:21])
                begin
                    h1_ctrl_s2 = 3'b001;
                end
            else
                begin
                    h1_ctrl_s2 = 3'b000;
                end
        end

        else

//===========================================================================================
//                          check for s2  ADD XXX ADD / ADD XXX NAND
//                                       NAND XXX ADD / NAND XXX NAND hazard
//===========================================================================================
        if(((MEM_WB[31:26] == 6'b00_0001) && 
           ((RF_EX[31:26] == 6'b00_0001)||(RF_EX[31:26] == 6'b00_0001) || (RF_EX[31:26] == 6'b10_1100))) ||
           ((MEM_WB[31:26] == 6'b00_0001) && 
           ((RF_EX[31:26] == 6'b00_0001)||(RF_EX[31:26] == 6'b00_0001) || (RF_EX[31:26] == 6'b10_1100))) ||  
           ((MEM_WB[31:26] == 6'b10_1100) && 
           ((RF_EX[31:26] == 6'b00_0001)||(RF_EX[31:26] == 6'b00_0001) || (RF_EX[31:26] == 6'b10_1100))))
        begin
        
        // check 2nd operand
            if (MEM_WB[15:11] == RF_EX[25:21])
                begin
                    h1_ctrl_s2 = 3'b010;
                end
            else
                begin
                    h1_ctrl_s2 = 3'b000;
                end
        end
            
        else
               h1_ctrl_s2 = 3'b000;        
        
    end // for always block    
           
           
//========================================================================================================           
//========================================================================================================           
//========================================================================================================           
//========================================================================================================           


    always@(*)
        begin
    
//===========================================================================================
//               check for s1 ADD ADD / ADD NAND / ADD ADDI
//                            NAND ADD / NAND NAND / NAND ADDI 
//                            ADDI ADD / ADDI NAND / ADDI ADDI  hazard
//===========================================================================================
        if (((EX_MEM[31:26] == 6'b00_0001) && 
            ((RF_EX[31:26] == 6'b00_0001)||(RF_EX[31:26] == 6'b00_0001) || (RF_EX[31:26] == 6'b10_1100))) ||
            ((EX_MEM[31:26] == 6'b00_0001) && 
            ((RF_EX[31:26] == 6'b00_0001)||(RF_EX[31:26] == 6'b00_0001) || (RF_EX[31:26] == 6'b10_1100)))) 
        begin
    
        // check 1st operand
            if (EX_MEM[15:11] == RF_EX[20:16])
                begin
                    h1_ctrl_s1 = 3'b001;
                end
            else
                begin
                    h1_ctrl_s1 = 3'b000;
                end
        end

        else
//===========================================================================================
//                          check for s1  ADD XXX ADD / ADD XXX NAND
//                                       NAND XXX ADD / NAND XXX NAND hazard
//===========================================================================================

        if(((MEM_WB[31:26] == 6'b00_0001) && 
           ((RF_EX[31:26] == 6'b00_0001)||(RF_EX[31:26] == 6'b00_0001) || (RF_EX[31:26] == 6'b10_1100))) ||
           ((MEM_WB[31:26] == 6'b00_0001) && 
           ((RF_EX[31:26] == 6'b00_0001)||(RF_EX[31:26] == 6'b00_0001) || (RF_EX[31:26] == 6'b10_1100))))
   
           begin
                   
        // check 1st operand
            if (MEM_WB[15:11] == RF_EX[20:16])
                begin
                    h1_ctrl_s1 = 3'b010;
                end
            else
                begin
                    h1_ctrl_s1 = 3'b000;
                end
        end
            
        else
                    h1_ctrl_s1 = 3'b000;
    end
    
endmodule
