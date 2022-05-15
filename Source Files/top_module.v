`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2022 14:49:47
// Design Name: 
// Module Name: top_module
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


module top_module(input [0:3] dig_sig, op, input clk, rst, show, output reg[7:0] O, output reg[3:0] anodes);
    wire [3:0]d [3:0];
    genvar i ;
    generate 
        for (i = 0; i < 4; i = i + 1) begin: increment
            dig_inc  d2(dig_sig[i],d[i],rst,clk,d[i]);
        end
    endgenerate   
    wire [0:3] op_deb ;
    generate 
        for (i = 0; i < 4; i = i + 1) begin: debounce
            btn_deb d3(op[i],clk,rst,op_deb[i]);
        end
    endgenerate           
    reg [14:0]res;
    reg isNeg = 0;
    wire [7:0]nums [0:1];
    assign nums[0] =  d[0] + d[1] * (4'b1010);
    assign nums[1] =  d[2] + d[3] * (4'b1010);
    //wire [8:0] mid;
    //assign mid = (nums[0] + nums[1]) / 2;
    
    always @(posedge op_deb[0], posedge op_deb[1], posedge op_deb[2], posedge op_deb[3], posedge clk) begin
        if (op_deb[0] & ~ op_deb[1] & ~ op_deb[2] & ~ op_deb[3]) begin
            isNeg <= 0;
            res <= nums[0] + nums[1];
        end
        else if (op_deb[1]) begin
                isNeg <= (nums[0] < nums[1]) ? 1 : 0;
                res <= (isNeg) ? nums[1] - nums[0] : nums[0] - nums[1];
        end
        else if (op_deb[2] & ~ op_deb[0] & ~ op_deb[1] & ~ op_deb[3])
        begin
            isNeg <=0;
            res <= nums[0] * nums[1];
        end
        else if (op_deb[3] & ~ op_deb[1] & ~ op_deb[2] & ~ op_deb[0]) begin
            isNeg <= 0;
            res <= ((2'b10 * nums[0]) + nums[1]) / (2'b10 * nums[1]);
        end
        else 
            res <= res;
    end
 
    wire [3:0] digits [3:0];
    assign digits[0] = res % (4'b1010); 
    assign digits[1] = (res / (4'b1010)) % (4'b1010);  
    assign digits[2] = ((res / (4'b1010)) / (4'b1010)) % (4'b1010);  
    assign digits[3] = (((res / (4'b1010)) / (4'b1010)) / (4'b1010)) % (4'b1010);
    wire [7:0] bcds_o [3:0];
    wire [7:0] bcds_i [3:0];
    generate 
        for (i = 0; i < 4; i = i + 1) begin: displaying_output
            bcdtosevensegment x(digits[i],isNeg + 1, i + 1, bcds_o[i]);
        end
    endgenerate
    generate 
        for (i = 0; i < 4; i = i + 1) begin: displaying_input
            bcdtosevensegment v(d[i],0,i + 1,bcds_i[i]);
        end
    endgenerate
    wire [1:0] mux_sel;
    wire clk_count;
    clk_divider  #(5000) s(clk,rst,clk_count);
    counter  e(clk_count,0,0,0, mux_sel);
    always @(posedge clk_count, posedge rst) begin
        if ( rst == 1) begin
            O <= 8'b00000001;
            anodes <= 4'b0000;
        end
        else    begin
            if (show) begin
                case(mux_sel) 
                    2'b00:  begin 
                       O <= bcds_o[0];
                       anodes <= 4'b1110;
                    end
                    2'b01:  begin
                       O <= bcds_o[1];
                       anodes <= 4'b1101;
                    end
                    2'b10:  begin
                       O <= bcds_o[2];
                       anodes <= 4'b1011;
                    end
                    2'b11:  begin
                       O <= bcds_o[3];
                       anodes <= 4'b0111;
                    end
                    default: begin
                       O <= 0;
                       anodes <= 4'b1111;
                    end
                endcase       
            end
            else begin
                case(mux_sel) 
                    2'b00:  begin 
                       O <= bcds_i[0];
                       anodes <= 4'b1110;
                    end
                    2'b01:  begin
                       O <= bcds_i[1];
                       anodes <= 4'b1101;
                    end
                    2'b10:  begin
                       O <= bcds_i[2];
                       anodes <= 4'b1011;
                    end
                    2'b11:  begin
                       O <= bcds_i[3];
                       anodes <= 4'b0111;
                    end
                    default: begin
                       O <= 0;
                       anodes <= 4'b1111;
                    end
                endcase                      
            end     
        end  
    end   
endmodule
