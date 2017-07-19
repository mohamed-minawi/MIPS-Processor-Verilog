`timescale 1ns/1ns

module forwardingunit(  input [4:0] Rs_EX,            
                      	input [4:0] Rt_EX,
                        input [4:0] Rs_ID,            
                      	input [4:0] Rt_ID,            
                      	input [4:0] writereg_M,       
                      	input [4:0] writereg_WB,      
                        input RegWrite_M,       
                        input RegWrite_WB,      
                        output reg[1:0] ForwardAE,  
                        output reg[1:0] ForwardBE,
                        output reg ForwardAD,  
                        output reg ForwardBD );

always @(*)
    begin
        // Forward around EX hazards
        if (RegWrite_M
            && (writereg_M != 0)
            && (writereg_M == Rs_EX))
            ForwardAE = 2'b10;
        // Forward around MEM hazards
        else if (RegWrite_WB
            && (writereg_WB != 0)
            && (writereg_WB == Rs_EX))
            ForwardAE = 2'b01;
        // No hazards, use the value from ID/EX
        else
            ForwardAE = 2'b00;

        
         // Forward around EX hazards
        if (RegWrite_M
            && (writereg_M != 0)
            && (writereg_M == Rt_EX))
            ForwardBE = 2'b10;
        // Forward around MEM hazards
        else if (RegWrite_WB
            && (writereg_WB != 0)
            && (writereg_WB == Rt_EX))
            ForwardBE = 2'b01;
        // No hazards, use the value from ID/EX
        else
            ForwardBE = 2'b00;

        ForwardAD = (writereg_M !=0) && (Rs_ID == writereg_M) && RegWrite_M;
        ForwardBD = (writereg_M !=0) && (Rt_ID == writereg_M) && RegWrite_M;

            
    end

endmodule 