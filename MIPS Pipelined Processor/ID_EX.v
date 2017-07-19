`timescale 1ns/1ns

module ID_EX(input clk, 
             input rst,
             input[31:0] dataone_ID,
             output reg [31:0] dataone_Ex,
             input[31:0] WriteData_ID,
             output reg [31:0] WriteData_Ex,
             input[31:0] extendedimm_ID,
             output reg [31:0] extendedimm_Ex,
             input [31:0] Instr_ID,
             output reg [31:0] Instr_Ex,
             input RegWrite_ID,
             output reg RegWrite_Ex,
             input MemtoReg_ID, 
             output reg MemtoReg_Ex,
             input MemWrite_ID, 
             output reg MemWrite_Ex, 
             input [3:0]ALUControl_ID,
             output reg [3:0]ALUControl_Ex,
             input ALUSrc_ID,
             output reg ALUSrc_Ex,  
             input RegDst_ID,
             output reg RegDst_Ex);
  
  always@(posedge clk)
    begin
      if (rst) begin

        dataone_Ex <= 0;
        WriteData_Ex <= 0;
        extendedimm_Ex <= 0;
        Instr_Ex <= 0;
        RegWrite_Ex <= 0;
        MemtoReg_Ex <= 0;
        MemWrite_Ex <= 0;
        ALUControl_Ex <= 0;
        ALUSrc_Ex <= 0;
        RegDst_Ex <= 0;
		 
      end

    else   begin

        dataone_Ex <= dataone_ID;
        WriteData_Ex <= WriteData_ID;
        extendedimm_Ex <= extendedimm_ID;
        Instr_Ex <= Instr_ID;
        RegWrite_Ex <= RegWrite_ID;
        MemtoReg_Ex <= MemtoReg_ID;
        MemWrite_Ex <= MemWrite_ID;
        ALUControl_Ex <= ALUControl_ID;
        ALUSrc_Ex <= ALUSrc_ID;
        RegDst_Ex <= RegDst_ID;

      end
    end
  
endmodule