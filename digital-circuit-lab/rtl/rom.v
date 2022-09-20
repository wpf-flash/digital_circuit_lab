/* verilator lint_off UNDRIVEN */
`timescale 1 ns / 1 ns
module SYNC_ROM #(
	parameter DWIDTH = 16,
	parameter AWIDTH = 16,
	parameter DEPTH  = 1 << AWIDTH
)(
	input clk,
	input en,
	input [AWIDTH - 1 : 0] addr,
	output reg [DWIDTH - 1 : 0] dout
);

	reg [DWIDTH - 1 : 0] mem[0 : DEPTH - 1];

	initial begin
		/*
		mem[0] = 16'b0000_0000_0000_0100; //mov  r0 #4, R[x0] = 4;
		mem[1] = 16'b0010_0100_0000_0000; //add  r1 r0, R[x1] += R[x0];
		mem[2] = 16'b0011_0100_0000_0000; //sub  r1 r0, R[x1] -= R[x0];
		mem[3] = 16'b0110_0100_0000_0000; //or   r1 r0, R[x1] |= R[x0];
		mem[4] = 16'b0100_0000_0000_0000; //andi r0 #0, R[x0] &= 0;
		mem[5] = 16'b0101_0100_0000_0000; //and  r1 r0, R[x1] &= R[x0]; 
		mem[6] = 16'b1101_0010_0000_0001; //str r2 #1, mem[1] = R[x2];
		mem[7] = 16'b1100_0000_0000_0001; //ld  #1 r0, R[x0] = mem[1];
		mem[8] = 16'b0111_0000_0000_0000; //jump #0
		*/
	end

// If not give a input(driven) to mem or initialize it, the verilator will 
// rise a undriven warning. But doesn't matter here, so we turn off this warning.


	always @(posedge clk) begin
		if (en) begin 
			dout <= mem[addr];		
		end
	end

endmodule
