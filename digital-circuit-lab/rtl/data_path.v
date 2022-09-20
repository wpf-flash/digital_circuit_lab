`timescale 1 ns / 1 ns

module data_path #(
	parameter DWIDTH = 16
)(
	input clk, rst_n, en_in,
	input en_pc_pulse,
	input alu_in_sel,
	input [7:0] offset_addr,offset,
	input [1:0] pc_ctrl, rd, rs,
	input [3:0]  reg_en,
	input [2:0] alu_func,
	output [DWIDTH - 1 : 0] pc_out,
	output  en_out,
	output pc_jump,
	/////////////////////////////////
	input [DWIDTH - 1 : 0]r_ram_data,  //input
	input ram_en,
	output [DWIDTH - 1 : 0]w_ram_data   //output
);
	wire [DWIDTH - 1 : 0] rd_q, rs_q, alu_a, alu_b, alu_out;
	wire en_out_group, en_out_alu_mux;
	wire [DWIDTH - 1 : 0] d_in;

	assign w_ram_data = ram_en ? rs_q : w_ram_data;
	assign d_in = ram_en ? r_ram_data : alu_out;

	pc pc_i(
		.clk(clk),
		.rst_n(rst_n),       
		.en_in(en_pc_pulse),
		.pc_ctrl(pc_ctrl),
		.offset_addr(offset_addr), 	
		.pc_out(pc_out),
		.pc_jump(pc_jump)
    );

	reg_group reg_group_i (
		.clk(clk),
		.rst_n(rst_n),
		.en_in(en_in),
		.reg_en(reg_en),
		.d_in(d_in),
		.rd(rd),
		.rs(rs),
		.rd_q(rd_q),
		.en_out(en_out_group),
		.rs_q(rs_q)
	);
			
	alu_mux alu_mux_i (                                        
		.clk(clk),
		.rst_n(rst_n),
		.en_in(en_out_group),
		.rd_q(rd_q),
		.rs_q(rs_q),
		.offset(offset),
		.alu_in_sel(alu_in_sel),
		.alu_a(alu_a),
		.en_out(en_out_alu_mux),					
		.alu_b(alu_b)  		
	);

	alu alu_i (
		.clk(clk),
		.rst_n(rst_n),
		.en_in(en_out_alu_mux),					
		.alu_a(alu_a),
		.alu_b(alu_b),
		.alu_func(alu_func),
		.en_out(en_out),
		.alu_out(alu_out) 
	);				
		
endmodule				
				
