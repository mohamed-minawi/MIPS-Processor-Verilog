// file: Datapath.v
// author: @mohamed_minawi

`include "adder.v"
`include "alu32.v"
`include "flopr_param.v"
`include "mux2.v"
`include "mux4.v"
`include "regfile32.v"
`include "signext.v"
`include "sl2.v"

`timescale 1ns/1ns

module Datapath(input clk,
                input reset,
                input RegDst,
                input RegWrite,
                input ALUSrc,
                input Jump,
                input MemtoReg,
                input PCSrc,
                input [3:0] ALUControl,
                input [31:0] ReadData,
                input [31:0] Instr,
                output [31:0] PC,
                output ZeroFlag,
                output [31:0] WriteData, 
                output [31:0] ALUResult);


wire [31:0] PCNext, PCplus4, PCbeforeBranch, PCBranch;
wire [31:0] extendedimm, extendedimmafter, MUXresult, dataone, aluop2;
wire [4:0] writereg;

// PC 
flopr_param #(32) PCregister(clk,reset, PC,PCNext);
  adder #(32) pcadd4(PC, 32'd4 ,PCplus4);
slt2 shifteradd2(extendedimm,extendedimmafter);
adder #(32) pcaddsigned(extendedimmafter,PCplus4,PCbeforeBranch);
mux2 #(32) branchmux(PCplus4 , PCbeforeBranch, PCSrc, PCBranch);
mux2 #(32) jumpmux(PCBranch, {PCplus4[31:28],Instr[25:0],2'b00 }, Jump,PCNext);

// Register File 

registerfile32 RF(clk,RegWrite, reset, Instr[25:21], Instr[20:16], writereg, MUXresult, dataone,WriteData); 
mux2 #(5) writeopmux(Instr[20:16],Instr[15:11],RegDst, writereg);
mux2 #(32) resultmux(ALUResult, ReadData, MemtoReg,MUXresult);

// ALU

alu32 alucomp(dataone, aluop2, ALUControl, Instr[10:6], ALUResult, ZeroFlag);
signext immextention(Instr[15:0],extendedimm);
mux2 #(32) aluop2sel(WriteData,extendedimm, ALUSrc, aluop2);


endmodule