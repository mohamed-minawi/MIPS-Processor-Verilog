// file: slt2.v
// author: @mohamed_minawi

`timescale 1ns/1ns

module slt2(input [31:0] a,
            output [31:0] y);
            
assign y = a << 2;

endmodule