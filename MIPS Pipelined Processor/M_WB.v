`timescale 1ns/1ns

module M_WB(input clk,
            input rst,
            input [31:0] ReadData_M,
            output reg [31:0] ReadData_WB,
            input [31:0] ALUResult_M, 
            output reg [31:0]ALUResult_WB,
            input [4:0]writereg_M,
            output reg [4:0]writereg_WB,
            input RegWrite_M,
            output reg RegWrite_WB,
            input MemtoReg_M, 
            output reg MemtoReg_WB);
  
  always@(posedge clk )
    begin
      if (rst) begin

		ReadData_WB <= 0;
        ALUResult_WB <= 0;
        writereg_WB <= 0;

        RegWrite_WB <= 0;
        MemtoReg_WB <= 0;
      end
      
      else begin

		ReadData_WB <= ReadData_M;
        ALUResult_WB <= ALUResult_M;
        writereg_WB <= writereg_M;

        RegWrite_WB  <= RegWrite_M;
        MemtoReg_WB  <= MemtoReg_M;

      end
    end
endmodule