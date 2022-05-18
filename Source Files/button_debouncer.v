`timescale 1ns / 1ps

module btn_deb(input w, clk, rst, output z);
    reg D1,D2,D3;
    always @(posedge clk) begin
        D1 <= w;
        D2 <= D1;
        D3 <= D2;
    end
    assign z = (D1 && D2 && D3);
endmodule
