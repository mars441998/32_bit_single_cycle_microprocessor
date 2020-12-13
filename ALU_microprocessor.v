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
  input      [ 3:0]   alu_ctrl  ,
  input      [31:0]   in_1      ,
  input      [31:0]   in_2      ,
  input               alu_clk   ,
  output reg [31:0]   alu_rslt  ,
  output     [ 3:0]   alu_checks
);

reg             N,Z,C,V;

always @(posedge alu_clk) begin
  case(alu_ctrl)
    4'b0000:  begin   
      {C,alu_rslt} = in_1+in_2;           // ADD operation
      Z            = (alu_rslt==32'b0);
      N            = alu_rslt[31];
      V            = in_1[31]&&(in_2[31])&&(!alu_rslt[31]) || (!in_1[31])&&(!in_2[31])&&alu_rslt[31];
    end

    4'b0001:  begin   
      {C,alu_rslt} = in_1+(-in_2);        // SUB operation
      C            = !C;
      Z            = (alu_rslt==32'b0);
      N            = alu_rslt[31];
      V            = in_1[31]&&(!in_2[31])&&(!alu_rslt[31]) || (!in_1[31])&&(in_2[31])&&alu_rslt[31];
    end

    4'b0010:  begin   
      alu_rslt = in_1&in_2;               // AND operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    // Don't care
      C        = 0;    // Don't care
    end

    4'b0011:  begin  
      alu_rslt = in_1|in_2;               // OR operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    // Don't care
      C        = 0;    // Don't care
    end

    4'b0100:  begin  
      alu_rslt = ~(in_1&in_2);            // NAND operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    // Don't care
      C        = 0;    // Don't care
    end

    4'b0101:  begin  
      alu_rslt = ~(in_1|in_2);            // NOR operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    // Don't care
      C        = 0;    // Don't care
    end

    4'b0110:  begin  
      alu_rslt = ~(in_1^in_2);            // XNOR operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    // Don't care
      C        = 0;    // Don't care
    end

    4'b0111:  begin  
      alu_rslt = in_1^in_2;               // XOR operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    // Don't care
      C        = 0;    // Don't care
    end

    4'b1000:  begin  
      alu_rslt = !in_1;                   // NOT operation on first input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    // Don't care
      C        = 0;    // Don't care
    end

    4'b1001:  begin  
      alu_rslt = !in_2;                   // NOT operation on second input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    // Don't care
      C        = 0;    // Don't care
    end

    default:  begin                       //In default case, everything should be zero
      alu_rslt = 0; 
      {N,Z,C,V}= 4'b0100; 
    end
  endcase //case structure
end //always block

assign alu_checks = {N,Z,C,V};           // Flag for controlling values

endmodule //ALU_microprocessor