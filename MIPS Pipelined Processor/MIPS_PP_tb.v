// file: MIPS_SCP_tb.v
// author: @mohamed_minawi
// Testbench for MIPS_SCP

`timescale 1ns/1ns

module MIPS_PP_tb;

	//Inputs
	reg clk;
    reg reset;

	//Outputs


	//Instantiation of Unit Under Test
	MIPS_PP uut (
		.clk(clk),
		.reset(reset)
	);

    always #50 clk=!clk;
	initial begin
      
      $dumpfile("dump.vcd"); $dumpvars;
      
	clk=0;
	reset=1;
	#100; //cycle 1
      repeat(10) begin
	reset=0;
	#100;
      end
      $finish;
  	end
 endmodule