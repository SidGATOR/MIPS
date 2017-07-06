`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:46:23 03/17/2016 
// Design Name: 
// Module Name:    buf_EXMEM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module buf_EXMEM(input clk, input rst, input regwr, input memreg, input memwr, input memrd, input br, input zr,output reg regwro, output reg memrego,
output reg memwro, output reg memrdo,output reg bro,output reg zro, input [31:0]npc, input [31:0]aluout, input [31:0] reg2, input [4:0]ir5bit, 
output reg [31:0]npco, output reg [31:0]aluouto, output reg [31:0] reg2o, output reg [4:0] ir5bito);

always@(posedge clk)
begin
if(!rst)
begin
regwro <= 0;
memrego <= 0;
memwro <= 0;
memrdo <= 0;
bro <= 0;
zro <= 0 ;
aluouto <= 0;
npco <= 0;
reg2o <= 0;
ir5bito <= 0;
end
else
begin
regwro <= regwr;
memrego <= memreg;
memwro <= memwr;
memrdo <= memrd;
bro <= br;
zro <= zr;
aluouto <= aluout;
npco <= npc;
reg2o <= reg2;
ir5bito <= ir5bit;
end
end
endmodule
