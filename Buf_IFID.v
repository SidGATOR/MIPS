`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:19:03 03/17/2016 
// Design Name: 
// Module Name:    Buf_IFID 
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
module Buf_IFID(input clk, input rst, input [31:0]npc, input [31:0]instin, output reg [31:0]npco, output reg [31:0]instout
    );
always@(posedge clk)
if(!rst)
begin
npco <= 0;
instout <= 0;
end
else
begin
npco <= npc;
instout <= instin;
end
endmodule
