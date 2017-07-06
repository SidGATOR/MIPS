`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:09:53 03/17/2016 
// Design Name: 
// Module Name:    PC 
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
module PC(input clk, input rst, input [31:0] din, output reg [31:0] dout
    );

always@(posedge clk,negedge rst)
begin
if(!rst)
	dout <= 32'b0;
	else
	dout <= din;
end

endmodule
