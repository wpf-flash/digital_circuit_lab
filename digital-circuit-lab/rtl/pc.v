/* verilator lint_off UNUSED */
`timescale 1 ns / 1 ns
module pc #(
	parameter DWIDTH = 16
)(
    input clk, rst_n, en_in,
    input [1 : 0] pc_ctrl,
    input [7 : 0] offset_addr,
    output reg [DWIDTH - 1 : 0] pc_out,
    output reg pc_jump
);

	always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'b0) begin
			pc_out <= {(DWIDTH){1'b0}};
        end
		else begin
			if (en_in == 1'b1) begin
				case (pc_ctrl)
                    2'b00: begin 
                                pc_out <= pc_out;
                                pc_jump <= 0;
                    end
					2'b01: begin 
                                pc_out <= pc_out + 1;
                                pc_jump <= 0;
                    end
                    2'b10: begin 
                                pc_out <= {{(DWIDTH-8){1'b0}},offset_addr};
                                pc_jump <= 1;
                    end
                    default: begin
                                pc_out <= pc_out;
                                pc_jump <= pc_jump;
                    end
                endcase

            end
        end   
	end
endmodule
