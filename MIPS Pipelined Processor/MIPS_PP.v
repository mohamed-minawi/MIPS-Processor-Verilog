// file: MIPS_SCP.v
// author: @mohamed_minawi

`include "datapath.v"
`include "ram.v"
`include "rom.v"
`include "control.v"

`timescale 1ns/1ns


module MIPS_PP(input clk,
                input reset);
                
wire [31:0] PC, Instr_IF, Instr_ID, ReadData, WriteData, ALUResult;
wire RegDst,RegWrite, ALUSrc, Jump, MemtoReg, B , MemWrite_ID, MemWrite_M, Branch;
wire [3:0] ALUControl;

Datapath datapathcomp(clk, reset, RegDst,RegWrite, ALUSrc, B,Jump,MemtoReg ,
                     MemWrite_ID,Branch , ALUControl,ReadData, Instr_IF, MemWrite_M, Instr_ID ,PC, 
                     WriteData,ALUResult);


Controlunit controller(Instr_ID[31:26], Instr_ID[5:0],MemtoReg,MemWrite_ID,
                        ALUSrc, RegDst, RegWrite, Jump, Branch, B, ALUControl);


ram dmem(clk,MemWrite_M,ALUResult, WriteData, ReadData);

rom imem(PC,Instr_IF);

endmodule