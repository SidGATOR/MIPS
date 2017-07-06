`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:40 03/17/2016 
// Design Name: 
// Module Name:    mux5bit 
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
module mux5bit(input [4:0] inp1, input [4:0] inp2, input sel, output [4:0] outp
    );
assign outp = (sel==1'b0) ? inp1 : inp2;

endmodule
