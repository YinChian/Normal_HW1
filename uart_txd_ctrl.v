module uart_txd_ctrl(
	input clk_50M,
	input reset_n,
	input [7:0] tx_data,	//Data
	input tick,				//9600Hz
	input start,			//Trigger
	output out				//TxD output
);
	
	//Package the data into uart type
	wire [10:0] out_data;
	wire valid;
	
	//8bit data to 11bit serial output
	transmittify tidy(
	
		//Basics
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		
		//Clock Control
		.valid_i(start),
		.valid_o(valid),
		
		//Data Input/Output
		.orig_data(tx_data),
		.out_data(out_data)
		
	);
	
	//Shift out the data
	shift_reg shift(
		
		//Basics
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		
		//9600Hz input
		.enable(tick),
		
		//Load Control
		.load_en(valid),
		.load(out_data),
		
		//TxD output
		.out(out)
		
	);
	
endmodule 