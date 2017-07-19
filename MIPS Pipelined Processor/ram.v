// file: ram.v
// author: @mohamed_minawi
`timescale 1ns/1ns

module ram(clk,we,adr,din,dout);

parameter depth =128;
parameter bits = 32;
parameter width = 32;

input clk, we;
input [bits-1:0] adr;
input [width-1:0] din;

output [width-1:0] dout;

reg [width-1:0] Dmem [depth-1:0];
    
assign dout = Dmem[adr];
    
always @ (posedge clk) begin
	
    if (we) 
		Dmem[adr] <= din;
		 
end

endmodule