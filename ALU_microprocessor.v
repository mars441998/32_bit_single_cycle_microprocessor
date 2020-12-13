`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company       : Self-made
// Engineer      : Muhammad Abdur-Rehman Siddiqui
//
// Create Date   : 15:54:41 12/06/2020
// Design Name   :
// Module Name   : ALU_microprocessor
// Project Name  : Single cycle 16-bit ARM Microprocessor
// Target Devices:
// Tool versions : ISE Design Suite 14.7
// Description   : ALU module for the processor
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module ALU_microprocessor (
  input      [ 1:0]   alu_ctrl  ,
  input      [31:0]   in_1      ,
  input      [31:0]   in_2      ,
  output reg [31:0]   alu_rslt  ,
  output     [ 3:0]   alu_checks
);

  reg             N,Z,C,V;

  always @(alu_ctrl,in_1,in_2)
    case(alu_ctrl)
      2'b00:  begin   {C,alu_rslt}=in_1+in_2;        // ADD
        Z=(alu_rslt==32'b0);
        N=alu_rslt[31];
        V=in_1[31]&&in_2[31]&&(!alu_rslt[31])
          ||(!in_1[31])&&(!in_2[31])&&alu_rslt[31];
      end
      2'b01:  begin   {C,alu_rslt}=in_1+(-in_2);     // SUB
        C=!C;
        Z=(alu_rslt==32'b0);
        N=alu_rslt[31];
        V=in_1[31]&&(!in_2[31])&&(!alu_rslt[31])
          ||(!in_1[31])&&(in_2[31])&&alu_rslt[31];
      end
      2'b10:  begin   alu_rslt=in_1&in_2;            // AND
        Z=(alu_rslt==32'b0);
        N=alu_rslt[31];
        V=0;    // Don't care
        C=0;    // Don't care
      end
      2'b11:  begin   alu_rslt=in_1|in_2;            // OR (or ORR)
        Z=(alu_rslt==32'b0);
        N=alu_rslt[31];
        V=0;    // Don't care
        C=0;    // Don't care
      end
      default:  begin alu_rslt=0; {N,Z,C,V}=4'b0100; end
    endcase

    assign alu_checks = {N,Z,C,V};  // BEWARE:  Whether these are saved in controller depends on instruction.
endmodule