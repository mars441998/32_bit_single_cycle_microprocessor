`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company       : Self-made
// Engineer      : Muhammad Abdur-Rehman Siddiqui
//
// Create Date   : 15:54:41 06/12/2020
// Design Name   : 16-bit Advanced Microprocessor Design 
// Module Name   : ALU_microprocessor
// Project Name  : Single cycle 16-bit ARM Microprocessor
// Target Devices: Any FPGA family
// Tool versions : ISE Design Suite 14.7
// Description   : ALU module for the processor
//
// Dependencies  : None
//
// Revision      : 0.1
// Revision 0.01 - File Created
// Additional Comments:
//
// An advanced working ALU module which can perform several mathematical and
// logical operations on the operands
//////////////////////////////////////////////////////////////////////////////////
module ALU_microprocessor (
  input      [ 3:0]   alu_ctrl  ,
  input      [31:0]   in_1      ,
  input      [31:0]   in_2      ,
  input               alu_clk   ,
  output reg [31:0]   alu_rslt  ,
  output     [ 3:0]   alu_checks          // Flag values
);

reg             N;                        // Sign bit     (to see if result is negative or not)
reg             Z;                        // Zero bit     (to see if result is zero or not)
reg             C;                        // Carry bit    (to see if result generates carry)
reg             V;                        // Overflow bit (to see if overflow occurs or not)

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

    4'b1010:  begin
      alu_rslt = in_1<<1;                   // Left shift operation on first input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    
      C        = alu_rslt[31];
    end

    4'b1011:  begin
      alu_rslt = in_2<<1;                   // Left shift operation on second input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    
      C        = alu_rslt[31];
    end

    4'b1100:  begin
      alu_rslt = in_1>>1;                   // Right shift operation on first input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    
      C        = alu_rslt[0];
    end

    4'b1101:  begin
      alu_rslt = in_1>>1;                   // Right shift operation on second input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    
      C        = alu_rslt[0];
    end    

    default:  begin                         // In default case, everything should be zero
      alu_rslt = 0; 
      {N,Z,C,V}= 4'b0100;                   // Zero flag bit should be 1 to indicate the default case
    end
  endcase //case structure
end //always block

assign alu_checks = {V,Z,C,N};              // Assigning Flag values to alu_checks

endmodule //ALU_microprocessor