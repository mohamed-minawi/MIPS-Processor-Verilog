// file: flopr_param.v
// author: @mohamed_minawi
`timescale 1ns/1ns

module flopr_param (clk, rst,en ,q,d);

parameter n=32;
input clk,rst;
input [n-1:0] d;
input en;
output reg [n-1:0] q;

always @ (posedge clk)

  if(rst) q<=0;
  else if (!en) q<=q;
  else q<=d;
    
endmodule

