`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2022 15:16:41
// Design Name: 
// Module Name: dig_inc
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


module dig_inc(input sig, input [3:0] digit, input rst, input clk, output reg [3:0] result);
    wire rise;
    reg [3:0] o = 1'b0000;
    edg_dec r (sig, clk, rise);
    always @(posedge rise, posedge rst) begin
        if (rst)
            result <= 0;
        else
            result <= (digit + 1) % 10; 
    end
    //assign result = rst ? 0 : (digit + o) % 10;
endmodule
