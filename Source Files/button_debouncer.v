`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2022 14:28:52
// Design Name: 
// Module Name: btn_deb
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


module btn_deb(input w, clk, rst, output z);
    reg D1,D2,D3;
    always @(posedge clk) begin
        D1 <= w;
        D2 <= D1;
        D3 <= D2;
    end
    assign z = (D1 && D2 && D3);
endmodule
