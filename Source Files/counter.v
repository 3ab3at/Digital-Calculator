`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2022 16:17:43
// Design Name: 
// Module Name: counter
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


module counter #(parameter n = 2) (input clk, reset, UpDown, Inc, output reg [n-1 : 0] count);
always @(posedge clk, posedge reset) begin
    if (reset == 1)
        count <= 0;
    else if (UpDown == 0) 
        count <= count + Inc + 1;
    else
        count <= count - Inc - 1;
end
endmodule