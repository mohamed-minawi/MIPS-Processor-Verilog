// file: MIPS_SCP.v
// author: @mohamed_minawi

`include "datapath.v"
`include "ram.v"
`include "rom.v"
`include "control.v"

`timescale 1ns/1ns


module MIPS_SCP(input clk,
                input reset);
                
wire [31:0] PC, Instr, ReadData, WriteData, ALUResult;
wire RegDst,RegWrite, ALUSrc, Jump, MemtoReg, PCSrc , Zero, MemWrite;
wire [3:0] ALUControl;

Datapath datapathcomp(clk, reset, RegDst,RegWrite, ALUSrc,Jump,MemtoReg ,
                     PCSrc,ALUControl,ReadData, Instr, PC, Zero, 
                     WriteData,ALUResult);


Controlunit controller(Instr[31:26], Instr[5:0], Zero,MemtoReg,MemWrite,
                        ALUSrc, RegDst, RegWrite, Jump, PCSrc, ALUControl);


ram dmem(clk,MemWrite,ALUResult, WriteData, ReadData);

rom imem(PC,Instr);

endmodule