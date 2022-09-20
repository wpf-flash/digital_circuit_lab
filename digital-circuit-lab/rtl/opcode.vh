`ifndef __OPCODE_VH__
`define __OPCODE_VH__

`define MOVI   4'b0000
`define ADDI   4'b0001
`define ADD    4'b0010
`define SUB    4'b0011
`define ANDI   4'b0100
`define AND    4'b0101
`define OR     4'b0110
`define JUMP   4'b0111    //example  
`define LOAD   4'b1100    //example  1100_00XX_0000_0000  load mem[0] 到 R0
`define STORE  4'b1101    //example  1101_XX00_0000_0001  store R0 的数到 mem[1]

`endif
