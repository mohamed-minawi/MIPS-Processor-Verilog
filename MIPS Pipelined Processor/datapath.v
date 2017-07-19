// file: Datapath.v
// author: @mohamed_minawi

`include "adder.v"
`include "alu32.v"
`include "flopr_param.v"
`include "mux2.v"
`include "mux3.v"
`include "regfile32.v"
`include "signext.v"
`include "sl2.v"
`include "EX_M.v"
`include "ID_EX.v"
`include "IF_ID.v"
`include "M_WB.v"
`include "forwardingunit.v"
`include "hazardunit.v"

`timescale 1ns/1ns

module Datapath(input clk,
                input reset,
                input RegDst_ID,
                input RegWrite_ID,
                input ALUSrc_ID,
                input B, 
                input Jump_ID,
                input MemtoReg_ID,
                input MemWrite_ID,
                input Branch_ID,
                input [3:0] ALUControl_ID,
                input [31:0] ReadData_M,
                input [31:0] Instr_IF,
                output MemWrite_M,
                output [31:0] Instr_ID,
                output [31:0] PC_IF,
                output [31:0] WriteData_M, 
                output [31:0] ALUResult_M);


wire [31:0] PCNEXT_IF, PCplus4_IF, PCplus4_ID;
wire [31:0] PCBranch_ID,PCbeforeBranch;
wire [31:0] extendedimm_ID, extendedimm_Ex, extendedimmafter;
wire [31:0] dataone_ID ,dataone_Ex;
wire [31:0] WriteData_ID, WriteData_Ex;
wire [31:0] ALUResult_Ex, ALUResult_WB, ALUResult_Mem;
wire [31:0] MUXresult_WB,  aluop2, SrcA_EX, SrcB_EX;
wire [31:0] ReadData_WB;
wire [4:0]  writereg_Ex, writereg_M, writereg_WB ;
wire ZeroFlag_Ex;
wire [31:0] Instr_Ex;
wire RegWrite_Ex, RegWrite_M, RegWrite_WB;
wire MemtoReg_Ex, MemtoReg_M, MemtoReg_WB;
wire MemWrite_Ex, MemWrite_M;
wire [3:0] ALUControl_Ex;
wire ALUSrc_Ex;
wire RegDst_Ex;
wire [1:0] ForwardAE,ForwardBE;
wire ForwardAD, ForwardBD;
wire Flush_Ex, Stall_IF, Stall_ID; 
wire BranchMUXselect, Equal_ID;
wire [31:0] equalone,equaltwo;
// Fetch Stage

  flopr_param #(32) PCregister(clk, reset,!Stall_IF ,PC_IF, PCNEXT_IF);
adder #(32) pcadd4(PC_IF, 32'd4 , PCplus4_IF);
assign BranchMUXselect = ((B ^ Equal_ID) & Branch_ID);
mux2 #(32) branchmux(PCplus4_IF , PCBranch_ID, BranchMUXselect , PCNEXT_IF);
  //  mux2 #(32) jumpmux(PCbeforeBranch, {PCplus4_ID[31:28],Instr_ID[25:0],2'b00 }, Jump_ID, PCNEXT_IF);
  
// IF_ID

  IF_ID Fetch_Decode_Buffer(clk,reset | BranchMUXselect | Jump_ID ,Stall_ID,PCplus4_IF,PCplus4_ID,Instr_IF,Instr_ID);

// Decode Stage

signext immextention(Instr_ID[15:0],extendedimm_ID);
slt2 shifteradd2(extendedimm_ID,extendedimmafter);
registerfile32 RF(clk,RegWrite_WB, reset, Instr_ID[25:21], Instr_ID[20:16], writereg_WB, MUXresult_WB, dataone_ID,WriteData_ID); 
mux2 #(32) equalonemux(dataone_ID,ALUResult_Mem,ForwardAD,equalone);
mux2 #(32) equaltwomux(WriteData_ID,ALUResult_Mem,ForwardBD,equaltwo);
assign Equal_ID = (equalone==equaltwo);
adder #(32) pcaddsigned(extendedimmafter, PCplus4_ID, PCBranch_ID);

// ID_EX

ID_EX Decode_Execute_Buffer(clk, reset , dataone_ID, dataone_Ex,WriteData_ID,WriteData_Ex, extendedimm_ID,extendedimm_Ex, Instr_ID,Instr_Ex, RegWrite_ID, RegWrite_Ex, 
                            MemtoReg_ID, MemtoReg_Ex, MemWrite_ID,MemWrite_Ex, ALUControl_ID, ALUControl_Ex, ALUSrc_ID, ALUSrc_Ex, RegDst_ID, RegDst_Ex);

// Execute Stage

mux3 forwardmuxA (dataone_Ex, MUXresult_WB, ALUResult_Mem, ForwardAE, SrcA_EX);
mux3 forwardmuxB (WriteData_Ex, MUXresult_WB, ALUResult_Mem, ForwardBE, aluop2);
alu32 alucomp(SrcA_EX, SrcB_EX, ALUControl_Ex, Instr_Ex[10:6], ALUResult_Ex, ZeroFlag_Ex);
mux2 #(32) aluop2sel(aluop2,extendedimm_Ex, ALUSrc_Ex, SrcB_EX);
mux2 #(5) writeopmux(Instr_Ex[20:16],Instr_Ex[15:11],RegDst_Ex, writereg_Ex);

// EX_M
EX_M Execute_Memory_Buffer(clk, reset, ALUResult_Ex, ALUResult_Mem, aluop2, WriteData_M, writereg_Ex, writereg_M,
                           RegWrite_Ex, RegWrite_M, MemtoReg_Ex, MemtoReg_M, MemWrite_Ex, MemWrite_M );

assign ALUResult_M = ALUResult_Mem;

// Memory Stage

// Forwarding Unit

forwardingunit Forward_Unit( Instr_Ex [25:21], Instr_Ex [20:16], Instr_ID [25:21], Instr_ID [20:16], writereg_M, writereg_WB, RegWrite_M, RegWrite_WB, ForwardAE, ForwardBE, ForwardAD, ForwardBD);
  
hazardunit hazard_unit(Instr_Ex [20:16], Instr_ID [25:21], Instr_ID [20:16], writereg_M,writereg_Ex,MemtoReg_Ex,MemtoReg_M,RegWrite_Ex,Branch_ID,Jump_ID,
Stall_IF,Stall_ID,Flush_Ex );

// M_WB

M_WB Memory_WriteBack_Buffer(clk,reset, ReadData_M, ReadData_WB, ALUResult_M, ALUResult_WB, writereg_M, writereg_WB,
                             RegWrite_M, RegWrite_WB, MemtoReg_M, MemtoReg_WB);

// WriteBack Stage

mux2 #(32) resultmux(ALUResult_WB, ReadData_WB, MemtoReg_WB, MUXresult_WB); 

endmodule
