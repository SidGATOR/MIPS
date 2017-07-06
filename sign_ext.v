`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:15:55 03/17/2016 
// Design Name: 
// Module Name:    sign_ext 
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
module sign_ext(input [15:0] inp1, output [31:0] outp
    );
assign outp = {16'b0,inp1};

endmodule
