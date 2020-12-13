`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company       : Self-made
// Engineer      : Muhammad Abdur-Rehman Siddiqui
//
// Create Date   : 15:54:41 12/06/2020
// Design Name   :
// Module Name   : tb_ALU_microprocessor
// Project Name  : Single cycle 16-bit ARM Microprocessor
// Target Devices:
// Tool versions : ISE Design Suite 14.7
// Description   : Test bench for ALU module for the processor
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module tb_ALU_microprocessor;

// Inputs
reg [3:0] alu_ctrl;
reg [31:0] in_1;
reg [31:0] in_2;
reg alu_clk;

// Outputs
wire [31:0] alu_rslt;
wire [3:0] alu_checks;

// Instantiate the Unit Under Test (UUT)
ALU_microprocessor uut (
  .alu_ctrl(alu_ctrl), 
  .in_1(in_1), 
  .in_2(in_2), 
  .alu_clk(alu_clk), 
  .alu_rslt(alu_rslt), 
  .alu_checks(alu_checks)
);

always #10 alu_clk = ~alu_clk;
  
initial begin
// Initialize Inputs
  alu_ctrl    = 0;
  in_1        = 0;
  in_2        = 0;
  alu_clk     = 0;

  // Wait 10 ns for global reset to finish
  @(posedge alu_clk);

  //Initial checking for functionality verification
  @(posedge alu_clk);
  in_1        = 32'b1;
  in_2        = 32'b1;
  alu_ctrl    = 0;
  
  //Maximum Input randomization
  repeat(10000)@(posedge alu_clk) begin
  //for (integer i = 0; i<(2**32); i=i+1) begin
    in_1     = $random;
    in_2     = $random;
    alu_ctrl = $random;
    //@(posedge alu_clk);
  end //repeat
end //initial
      
endmodule

