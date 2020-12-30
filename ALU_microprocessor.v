`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company       : Self-made
// Engineer      : Muhammad Abdur-Rehman Siddiqui
//
// Create Date   : 15:55:51 06/12/2020
// Design Name   : 32-bit Advanced Microprocessor Design 
// Module Name   : ALU_microprocessor
// Project Name  : Single cycle 16-bit ARM Microprocessor
// Target Devices: Any FPGA family
// Tool versions : ISE Design Suite 15.7
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
  input      [ 5:0]   alu_ctrl  ,
  input      [31:0]   in_1      ,
  input      [31:0]   in_2      ,
  input               alu_clk   ,
  output reg [31:0]   alu_rslt  ,
  output     [ 3:0]   alu_checks            // Flag values
);

reg             N;                          // Sign bit     (to see if result is negative or not)
reg             Z;                          // Zero bit     (to see if result is zero or not)
reg             C;                          // Carry bit    (to see if result generates carry)
reg             V;                          // Overflow bit (to see if overflow occurs or not)

always @(posedge alu_clk) begin
  case(alu_ctrl)

/* 
   ==============================================================================================
                           ARITHMETIC OPERATIONS FOR THE ALU DESIGN
                In arithmetic operations, flag bits have greater effect by the 
                                    results generated 
   ==============================================================================================
*/

    5'd0 :  begin   
      {C,alu_rslt} = in_1 + in_2;           // ADD operation
      Z            = (alu_rslt==32'b0);
      N            = alu_rslt[31];
      V            = in_1[31]&&(in_2[31])&&(!alu_rslt[31]) || (!in_1[31])&&(!in_2[31])&&alu_rslt[31];
    end

    5'd1 :  begin   
      {C,alu_rslt} = in_1 + (-in_2);        // SUB operation
      C            = !C;
      Z            = (alu_rslt==32'b0);
      N            = alu_rslt[31];
      V            = in_1[31]&&(!in_2[31])&&(!alu_rslt[31]) || (!in_1[31])&&(in_2[31])&&alu_rslt[31];
    end

    5'd2 :  begin
      alu_rslt = in_1;                      // Passing first input as it is on output
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    
      C        = 0;
    end

     5'd3 :  begin
      alu_rslt = in_2;                      // Passing second input as it is on output
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    
      C        = 0;
    end

     5'd4 :  begin
      {C,alu_rslt} = in_1 + 1;              // Incrementing first input by 1
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    
    end

    5'd5 :  begin
      {C,alu_rslt} = in_2 + 1;              // Incrementing second input by 1
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    
    end

    5'd6 :  begin
      alu_rslt = in_1 - 1;                  // Decrementing first input by 1
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    
      C        = alu_rslt[31];
    end

    5'd7 :  begin
      alu_rslt = in_2 - 1;                  // Decrementing second input by 1
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;    
      C        = alu_rslt[31];
    end


/* 
   ==============================================================================================
                           LOGICAL OPERATIONS FOR THE ALU DESIGN
                In logical operations, flag bits usually does not have any effect by the 
                                    results generated 
   ==============================================================================================
*/

    5'd8 :  begin   
      alu_rslt = in_1 & in_2;               // AND operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      C        = 0;                         // Don't care
      V        = 0;                         // Don't care
    end

    5'd9 :  begin  
      alu_rslt = in_1 | in_2;               // OR operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    5'd10:  begin  
      alu_rslt = ~(in_1 & in_2);            // NAND operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    5'd11:  begin  
      alu_rslt = ~(in_1 | in_2);            // NOR operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    5'd12:  begin  
      alu_rslt = ~(in_1 ^ in_2);            // XNOR operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    5'd13:  begin  
      alu_rslt = in_1 ^ in_2;               // XOR operation
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    5'd14:  begin  
      alu_rslt = !in_1;                     // NOT operation on first input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    5'd15:  begin  
      alu_rslt = !in_2;                     // NOT operation on second input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    5'd16:  begin
      alu_rslt = in_1 << 1;                 // Left shift operation on first input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = alu_rslt[31];
    end

    5'd17:  begin
      alu_rslt = in_2 << 1;                 // Left shift operation on second input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = alu_rslt[31];
    end

    5'd18:  begin
      alu_rslt = in_1 >> 1;                 // Right shift operation on first input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = alu_rslt[0];
    end

    5'd19:  begin
      alu_rslt = in_1 >> 1;                 // Right shift operation on second input
      Z        = (alu_rslt==32'b0);
      N        = alu_rslt[31];
      V        = 0;                         // Don't care
      C        = alu_rslt[0];
    end

    5'd20:  begin
      alu_rslt = {in_1[30:0], in_1[31]};    // Left Circular Rotate (LCR) or shift on first input
      Z        = (alu_rslt==32'b0);
      N        = 0;                         // Don't care
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    5'd21:  begin
      alu_rslt = {in_2[30:0], in_2[31]};    // Left Circular Rotate (LCR) or shift on second input
      Z        = (alu_rslt==32'b0);
      N        = 0;                         // Don't care
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    5'd22:  begin
      alu_rslt = {in_1[0], in_1[31:1]};     // Right Circular Rotate (RCR) or shift on first input
      Z        = (alu_rslt==32'b0);
      N        = 0;                         // Don't care
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    5'd23:  begin
      alu_rslt = {in_2[0], in_2[31:1]};     // Right Circular Rotate (RCR) or shift on second input
      Z        = (alu_rslt==32'b0);
      N        = 0;                         // Don't care
      V        = 0;                         // Don't care
      C        = 0;                         // Don't care
    end

    default:  begin                         // In default case, everything should be zero
      alu_rslt = 0; 
      {N,Z,C,V}= 4'b0100;                   // Zero flag bit should be 1 to indicate the default case
    end
  endcase //case structure
end //always block

assign alu_checks = {V,Z,C,N};              // Assigning Flag values to alu_checks

endmodule //ALU_microprocessor