`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:11:15 03/17/2016 
// Design Name: 
// Module Name:    add_basic 
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
module add_basic_pc(input [31:0]inp1, input [31:0] inp2, input enb, output [31:0] outp
    );
assign outp = (enb==1) ? inp1+inp2: inp1;

endmodule
