`timescale 1ns/1ns

module EX_M(input clk,
            input rst,
            input [31:0] ALUResult_Ex,
            output reg [31:0] ALUResult_M,
            input [31:0] WriteData_Ex,
            output reg [31:0] WriteData_M,
            input [4:0] writereg_Ex,
            output reg [4:0] writereg_M,
            input RegWrite_Ex,
            output reg RegWrite_M,
            input MemtoReg_Ex, 
            output reg MemtoReg_M,
            input MemWrite_Ex, 
            output reg MemWrite_M);
  
  always@(posedge clk)
    begin
      if (rst)  begin
        ALUResult_M <= 0;
        WriteData_M <= 0;
        writereg_M <= 0;
        RegWrite_M <= 0;
        MemtoReg_M <= 0;
        MemWrite_M <= 0;
        end

      else begin
        ALUResult_M <= ALUResult_Ex;
        WriteData_M <= WriteData_Ex;
        writereg_M  <= writereg_Ex;
        RegWrite_M  <= RegWrite_Ex;
        MemtoReg_M  <= MemtoReg_Ex;
        MemWrite_M  <= MemWrite_Ex;
      end
    end
  
endmodule