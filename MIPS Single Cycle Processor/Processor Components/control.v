// Code your design here
// file: control.v
// author: @mohamed_minawi

`timescale 1ns/1ns

module Controlunit(input [5:0] Opcode, 
               input [5:0] Func,
               input Zero,
               output reg MemtoReg,
               output reg  MemWrite,
               output reg  ALUSrc,
               output reg  RegDst,
               output reg  RegWrite,
               output reg  Jump,
               output PCSrc,
               output reg  [3:0] ALUControl
               );
               
reg [11:0] temp;
reg Branch,B;

always @(*) begin 

    case (Opcode) 
        6'b000000: temp <= 12'b110000000000;        // R-type
        6'b100011: temp <= 12'b101001000000;        // LW
        6'b101011: temp <= 12'b001010000000;        // SW 
        6'b000100: temp <= 12'b000100000001;        // BEQ
        6'b000101: temp <= 12'b000100010001;        // BNE
        6'b001000: temp <= 12'b101000000000;        // ADDI
        6'b001001: temp <= 12'b101000000000;        // ADDIU
        6'b001100: temp <= 12'b101000000010;        // ANDI
        6'b001101: temp <= 12'b101000000011;        // ORI
        6'b001110: temp <= 12'b101000000100;        // XORI
        6'b001010: temp <= 12'b101000001000;        // SLTI
        6'b001011: temp <= 12'b101000001001;        // SLTIU
        6'b000010: temp <= 12'b000000100010;        // J
        6'b001111: temp <= 12'b101000001110;        // LUI
        default:   temp <= 12'bxxxxxxxxxxxx;        // NOP
    endcase
    
    // R Functions
if(Opcode==6'b000000) begin
    case (Func)
        6'b100000: ALUControl <= 4'b0000;    // ADD
        6'b100001: ALUControl <= 4'b0000;    // ADDU
        6'b100010: ALUControl <= 4'b0001;    // SUB
        6'b100011: ALUControl <= 4'b0001;    // SUBU
        6'b100100: ALUControl <= 4'b0010;    // AND
        6'b100101: ALUControl <= 4'b0011;    // OR
        6'b100110: ALUControl <= 4'b0100;    // XOR
        6'b100111: ALUControl <= 4'b1010;    // NOR
        6'b101010: ALUControl <= 4'b1000;    // SLT
        6'b101011: ALUControl <= 4'b1001;    // SLTU
        6'b000000: ALUControl <= 4'b0101;    // SLL
        6'b000010: ALUControl <= 4'b0110;    // SRL
        6'b000011: ALUControl <= 4'b0111;    // SRA
        6'b000100: ALUControl <= 4'b1011;    // SLLV
        6'b000110: ALUControl <= 4'b1100;    // SRLV
        6'b000111: ALUControl <= 4'b1101;    // SRAV
    endcase
  end  
    {RegWrite,RegDst,ALUSrc,Branch,MemWrite,MemtoReg,Jump,B,ALUControl} = temp;

end

assign PCSrc = Branch & (Zero ^ B);

endmodule