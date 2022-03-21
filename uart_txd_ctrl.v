module uart_txd_ctrl(
	input clk_50M,
	input reset_n,
	input [7:0] tx_data,
	input tick,
	input start,
	output out
);
	
	//Package the data into uart type
	wire [10:0] out_data;
	transmittify tidy(
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		.orig_data(tx_data),
		.out_data(out_data)
	);
	
	//Shift out the data
	shift_reg shift(
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		.enable(tick),
		.load_en(start),
		.load(out_data),
		.out(out)
	);
	
endmodule 