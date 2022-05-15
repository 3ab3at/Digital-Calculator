`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2022 16:33:50
// Design Name: 
// Module Name: main_sim
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


module main_sim();
    reg [0:3] dig_sig, op;  
    reg clk;
    wire [7:0] result;
    wire [3:0] anodes;
    reg rst;
    initial begin
     clk = 0;
     forever #10 clk = ~clk;
    end
    top_module UUT( dig_sig, op, clk,rst,1, result, anodes);
    integer i, j;
    initial begin
        rst = 1;
        #10;
        rst = 0;
        for (i = 0; i < 4; i = i + 1) dig_sig[i] <= 0; 
        for (i = 0; i < 4; i = i + 1) op[i] <= 0; 
        for (i = 0; i < 4; i = i + 1)
            repeat(18) #40 dig_sig[i] = !dig_sig[i];
        op[0] <= 1;
        #500;
        op[0] <= 0;
        op[1] <= 1;
        #500;
        op[1] <= 0;
        op[2] <= 1;
        #500;
        op[2] <= 0;
        op[3] <= 1;
        #500;
        repeat(18) #40 dig_sig[2] = !dig_sig[2];    
        op[3] <= 0;
        op[1] <= 1;
        #500;
        op[1] <= 0;
        op[3] <= 1;
        #500;
        repeat(6) #40 dig_sig[0] = !dig_sig[0];
        repeat(8) #40 dig_sig[1] = !dig_sig[1];
        op[3] <= 0;
        op[1] <= 1;
        #500;
        op[1] <= 0;
        op[3] <= 1;
        #500;
        op[3] <= 0;
        op[2] <= 1;
        #500;
        repeat(4) #40 dig_sig[2] = !dig_sig[2];
        repeat(4) #40 dig_sig[3] = !dig_sig[3];
        op[2] <= 0;
        op[3] <= 1;
    end
endmodule
