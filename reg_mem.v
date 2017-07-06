`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:51:43 03/14/2016 
// Design Name: 
// Module Name:    reg_mem 
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
module reg_mem(input clk, input rst, input regwrite, input [4:0] rs1, input [4:0] rs2,
input [4:0] wra, input [31:0] wd, output reg [31:0] rd1, output reg [31:0] rd2);
//integer i;
reg [31:0] mregm [31:0];
always@(posedge clk)
begin
if(!rst)
begin
mregm[31] <= 32'b0;
mregm[30] <= 32'b0;
mregm[29] <= 32'b0;
mregm[28] <= 32'b0;
mregm[27] <= 32'b0;
mregm[26] <= 32'b0;
mregm[25] <= 32'b0;
mregm[24] <= 32'b0;
mregm[23] <= 32'b0;
mregm[22] <= 32'b0;
mregm[21] <= 32'b0;
mregm[20] <= 32'b0;
mregm[19] <= 32'b0;
mregm[18] <= 32'b0;
mregm[17] <= 32'b0;
mregm[16] <= 32'b0;
mregm[15] <= 32'b0;
mregm[14] <= 32'b0;
mregm[13] <= 32'b0;
mregm[12] <= 32'b0;
mregm[11] <= 32'b0;
mregm[10] <= 32'b0;
mregm[9] <= 32'b0;
mregm[8] <= 32'b0;
mregm[7] <= 32'b0;
mregm[6] <= 32'b0;
mregm[5] <= 32'b0;
mregm[4] <= 32'b0;
mregm[3] <= 32'b0;
mregm[2] <= 32'b0;
mregm[1] <= 32'b0;
mregm[0] <= 32'b0;
end
else if(regwrite)
mregm[wra] <= wd;
end

always@(negedge clk)
begin
rd1 <= mregm[rs1];
rd2 <= mregm[rs2];
end
endmodule
