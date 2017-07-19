`timescale 1ns/1ns

module hazardunit(      input [4:0] Rt_EX,            
                        input [4:0] Rs_D,
                        input [4:0] Rt_D,
                        input [4:0] writereg_M,
                        input [4:0] writereg_EX,
                        input MemtoReg_E,
                        input MemtoReg_M,
                        input RegWrite_EX,
                        input Branch_ID, 
                        input Jump_ID,
                        output reg stall_IF_ID,
                        output reg stall_ID_EX,
                        output reg flush_EX_Mem);
reg lwstall, branchstall;
always @(*) begin

    lwstall= ((Rs_D==Rt_EX) || (Rt_D==Rt_EX)) && MemtoReg_E;

  branchstall =Branch_ID &
            (RegWrite_EX &
            (writereg_EX == Rs_D | writereg_EX == Rt_D) |
             MemtoReg_M &
            (writereg_M == Rs_D | writereg_M == Rt_D));



    stall_ID_EX = lwstall || branchstall || Jump_ID;
    stall_IF_ID = lwstall || branchstall || Jump_ID;
    flush_EX_Mem = lwstall || branchstall || Jump_ID;

    end

endmodule 