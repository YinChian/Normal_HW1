module uart_txd_ctrl(
	input clk_50M,
	input reset_n,
	input [7:0] tx_data,
	input tick,
	input start,
	output out,
	
	output [10:0] out_data,
	output [10:0] data
);
	
	//Package the data into uart type
	//wire [10:0] out_data;
	wire valid;
	transmittify tidy(
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		.valid_i(start),
		.orig_data(tx_data),
		.out_data(out_data),
		.valid_o(valid)
	);
	
	//Shift out the data
	shift_reg shift(
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		.enable(tick),
		.load_en(valid),
		.load(out_data),
		
		.out(out),
		
		.data(data)
	);
	
endmodule 