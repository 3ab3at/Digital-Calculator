`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2022 14:03:16
// Design Name: 
// Module Name: edg_dec
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


module edg_dec(input w, input clk, output z);
    parameter A = 1, B = 2, C = 3;
    reg [1:0] state, nextState;
    always @(w or state) begin
        case (state) 
            A: if (w) nextState <= B; else nextState <= A;
            B: if (w) nextState <= C; else nextState <= A;
            C: if (w) nextState <= C; else nextState <= A;
            default: nextState <= A;
        endcase
    end
    always @(posedge clk)
        state <= nextState;
    assign z = (state == B);
endmodule
