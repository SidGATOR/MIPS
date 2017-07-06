`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:39 03/17/2016 
// Design Name: 
// Module Name:    buf_IDEX 
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
module buf_IDEX(input clk, input rst, input regwr, input memreg, input memwr, input memrd, input br,input aluop1,
input aluop2, input alusrc, input regdst,output reg regwro, output reg memrego, output reg memwro, output reg memrdo,
output reg bro,output reg aluop1o, output reg aluop2o, output reg alusrco, output reg regdsto, input [31:0]npc, input [31:0]reg1,
input [31:0] reg2, input [31:0]signext, input [4:0] inst2016, input [4:0]inst1511,output reg [31:0]npco, output reg [31:0]reg1o,
output reg [31:0] reg2o, output reg [31:0]signexto, output reg [4:0] inst2016o, output reg [4:0]inst1511o);

always@(posedge clk)
begin
if(!rst)
begin
regwro <= 0;
memrego <= 0;
memwro <= 0;
memrdo <= 0;
bro <= 0;
aluop1o <= 0;
aluop2o <= 0;
alusrco <= 0;
regdsto <= 0;
npco <= 0;
reg1o <= 0;
reg2o <= 0;
signexto <= 0;
inst2016o <= 0;
inst1511o <= 0;
end
else
begin
regwro <= regwr;
memrego <= memreg;
memwro <= memwr;
memrdo <= memrd;
bro <= br;
aluop1o <= aluop1;
aluop2o <= aluop2;
alusrco <= alusrc;
regdsto <= regdst;
npco <= npc;
reg1o <= reg1;
reg2o <= reg2;
signexto <= signext;
inst2016o <= inst2016;
inst1511o <= inst1511;
end
end
endmodule
