// file: mux4.v
// author: @mohamed_minawi

`timescale 1ns/1ns

module mux4 (d0,d1,d2,d3,s,y);

parameter n=32;

input [n-1:0] d0,d1,d2,d3;
input [1:0] s;
output reg [n-1:0] y;

always @* begin

    case(s)
        2'b00: y<=d0;
        2'b01: y<=d1;
        2'b10: y<=d2;
        2'b11: y<=d3;
    endcase
    
end

endmodule
