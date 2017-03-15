// file: ALU.v
// author: @mohamed_minawi

`timescale 1ns/1ns

module alu32( input [31:0] a, 
            input [31:0] b,
            input [3:0] f,
            input [4:0] shamt,
            output reg [31:0] y, 
            output reg zero);

always @ (*) begin

    case (f)
        4'b0000: y = a + b;                             // ADD
        4'b0001: y = a - b;                             // SUB
        4'b0010: y = a & b;                             // AND
        4'b0011: y = a | b;                             // OR
        4'b0100: y = a ^ b;                             // XOR
        4'b0101: y = b << shamt;                        // SLL
        4'b0110: y = b >> shamt;                        // SRL
        4'b0111: y = $signed($signed(b) >>> shamt);     // SRA
        4'b1000: y = $signed(a) < $signed(b) ? 1 : 0;   // SLT
        4'b1001: y = a < b ? 1 : 0;                     // SLTU
        4'b1010: y = ~ (a | b);                         // NOR 
        4'b1011: y = b << a;                            // SLLV
        4'b1100: y = b >> a;                            // SRLV
        4'b1101: y = $signed($signed(b) >>> a);         // SRAV
        4'b1110: y = {b[15:0], 16'b0};                  // LUI
    endcase
         zero = (y==8'b0);
     end
endmodule