`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:01:19 03/17/2016 
// Design Name: 
// Module Name:    buf_MEMWB 
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
module buf_MEMWB(input clk, input rst, input regwr, input memreg,output reg regwro, output reg memrego,
	input [31:0] rddata, output reg [31:0]rddatao, input [31:0] rdalu, output reg [31:0]rdaluo,
	input [4:0] ir5bit, output reg [4:0] ir5bito);

always@(posedge clk)
begin
if(!rst)
begin
regwro <= 0;
memrego <= 0;
rdaluo <= 0;
rddatao <= 0;
ir5bito <= 0;
end
else
begin
regwro <= regwr;
memrego <= memreg;
rdaluo <= rdalu;
rddatao <= rddata;
ir5bito <= ir5bit;
end
end
endmodule
