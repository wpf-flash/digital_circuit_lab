`timescale 1 ns / 1 ns

module ram #(
	parameter DWIDTH = 16,
	parameter AWIDTH = 16,
	parameter DEPTH  = 1 << AWIDTH
)(
	input                       clk,
    input                       rst_n,
    input                       ram_en,
    input                       wen,
	input      [AWIDTH - 1 : 0] addr_i,
    input      [DWIDTH - 1 : 0] w_data_i,
    output reg [DWIDTH - 1 : 0] r_data_o,
    output ram_valid
);
    reg [DWIDTH - 1 : 0] mem[0 : DEPTH - 1];
    reg valid;
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            for ( i = 0; i < DEPTH; i = i + 1) begin
                mem[i] <= {(DWIDTH){1'b0}};
            end
            r_data_o <= {(DWIDTH){1'b0}};
            valid <= 0;
        end
        else begin
            if(ram_en) begin
                if (wen) begin
                    mem[addr_i] <= w_data_i;
                    valid <= 1;
                end
                else begin 
                    r_data_o <= mem[addr_i];
                    valid <= 1;        
                end
            end
            else begin
                valid <= 0;
            end
        end
    end

    assign ram_valid = valid ;

endmodule