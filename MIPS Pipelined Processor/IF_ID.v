`timescale 1ns/1ns

module IF_ID(input clk, 
             input rst,
             input stall,   
             input [31:0]PCplus4_IF, 
             output reg [31:0]PCplus4_ID, 
             input [31:0]Instr_IF,
             output reg [31:0]Instr_ID);
  
  always@(posedge clk)
    begin
    
      if (rst) begin
        PCplus4_ID <= 0;
        Instr_ID <= 0;
      end

      else if(stall) begin
        PCplus4_ID <= PCplus4_ID;
        Instr_ID <= Instr_ID;
        end

      else begin
		PCplus4_ID <= PCplus4_IF;
        Instr_ID <= Instr_IF;
      end

    end
  
endmodule