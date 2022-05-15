`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2022 16:14:14
// Design Name: 
// Module Name: bcd
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

module bcdtosevensegment(input [3:0]I, input [2:0] flag, idx, output reg[7:0]O);
    always @(I)
    begin
        if (flag == 0 && idx == 3) begin
             case(I) 
                0 : O = 8'b00000010;
                1 : O = 8'b10011110;
                2 : O = 8'b00100100;
                3 : O = 8'b00001100;
                4 : O = 8'b10011000;
                5 : O = 8'b01001000;
                6 : O = 8'b01000000;
                7 : O = 8'b00011110;
                8 : O = 8'b00000000;
                9 : O = 8'b00001000;
            endcase       
        end
        else if (flag == 2 && idx == 3)
            O = 8'b11111101;
        else
            case(I) 
                0 : O = 8'b00000011;
                1 : O = 8'b10011111;
                2 : O = 8'b00100101;
                3 : O = 8'b00001101;
                4 : O = 8'b10011001;
                5 : O = 8'b01001001;
                6 : O = 8'b01000001;
                7 : O = 8'b00011111;
                8 : O = 8'b00000001;
                9 : O = 8'b00001001;
            endcase
    end
endmodule

