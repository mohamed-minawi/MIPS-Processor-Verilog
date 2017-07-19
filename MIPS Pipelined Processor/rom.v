// file: rom.v
// author: @mohamed_minawi

`timescale 1ns/1ns

module rom(adr,dout);

parameter depth =256;
parameter bits = 32;
parameter width = 32;


input [bits-1:0] adr;
output [width-1:0] dout;

reg [width-1:0] Imem[depth-1:0];
    
initial
    $readmemh("memfile.txt", Imem);
    
  assign dout= Imem[adr/4]; 



endmodule