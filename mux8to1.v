`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2016 04:53:10 PM
// Design Name: 
// Module Name: mux8to1
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


module mux8to1(
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [31:0] in5,
    input [31:0] in6,
    input [31:0] in7,
    input [2:0] sel,
    output reg [31:0] out1
    );
    
    always@(*)
    begin
        case (sel)
          3'd0 : out1 = in0;
          3'd1 : out1 = in1;
          3'd2 : out1 = in2;
          3'd3 : out1 = in3;
          3'd4 : out1 = in4;
          3'd5 : out1 = in5;
          3'd6 : out1 = in6;
          3'd7 : out1 = in7;
        endcase
    end
    
endmodule
