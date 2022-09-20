/* verilator lint_off UNUSED */ 
`timescale 1ns / 1ns
module cpu_top #(
	parameter DWIDTH = 16,
	parameter AWIDTH = 16
)( input clk, 
   input rst_n, 
   input en_in
);
    ///////////////////////////////////rom
	wire en_ram_in, en_ram_out;
    wire [AWIDTH - 1 : 0] addr;
	wire [DWIDTH - 1 : 0] ins;
	///////////////////////////////////ram
	wire wen;
	wire [AWIDTH - 1 : 0] ram_addr;
	wire [DWIDTH - 1 : 0] w_ram_data;
	wire [DWIDTH - 1 : 0] r_ram_data;
	wire ram_valid;
    ///////////////////////////////////////
    cpu cpu_i (
		.clk(clk),
		.rst_n(rst_n),
		.en_in(en_in),
		.en_ram_out(en_ram_out),
		.ins(ins),
		.en_ram_in(en_ram_in),
		.addr(addr),

		////////////ram 
		.wen(wen),               	//output
		.ram_addr(ram_addr),
		.w_ram_data(w_ram_data),
		.ram_en (ram_en),

		.r_ram_data(r_ram_data),    		// input
		.ram_valid(ram_valid)
    );
	
	irom irom_i (
		// input
		.clk   (clk),
		.rst_n (rst_n),
		.addr  (addr),
		.ready (en_ram_in),
		// output
		.dout  (ins),
		.valid (en_ram_out)
	);

	ram ram_i (
		// input
		.clk   (clk),
		.rst_n (rst_n),
		.wen (wen),
		.addr_i  (ram_addr),
		.w_data_i (w_ram_data),
		.ram_en (ram_en),
		// output
		.r_data_o  (r_ram_data),
		.ram_valid (ram_valid)
	); 


endmodule
