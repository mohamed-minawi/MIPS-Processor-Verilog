// file: decoder4.v
// author: @mohamed_minawi

`timescale 1ns/1ns

module decoder4( input [3:0]   a,
                 output reg [15:0] y
                );
                
always @(*) begin

        if(a == 4'b0000)
            y <= 16'b0000000000000001;
        else if(a == 4'b0001)
            y <= 16'b0000000000000010;
        else if(a == 4'b0010)
            y <= 16'b0000000000000100;
        else if(a == 4'b0011)
            y <= 16'b0000000000001000;
        else if(a == 4'b0100)
            y <= 16'b0000000000010000;
        else if(a == 4'b0101)
            y <= 16'b0000000000100000;
        else if(a == 4'b0110)
            y <= 16'b0000000001000000;
        else if(a == 4'b0111)
            y <= 16'b0000000010000000;
        else if(a == 4'b1000)
            y <= 16'b0000000100000000;
        else if(a == 4'b1001)
            y <= 16'b0000001000000000;
        else if(a == 4'b1010)
            y <= 16'b0000010000000000;
        else if(a == 4'b1011)
            y <= 16'b0000100000000000;
        else if(a == 4'b1100)
            y <= 16'b0001000000000000;
        else if(a == 4'b1101)
            y <= 16'b0010000000000000;
        else if(a == 4'b111)
            y <= 16'b0100000000000000;
        else if(a == 4'b1111)
            y <= 16'b1000000000000000;
    end

endmodule 
