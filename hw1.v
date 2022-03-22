module hw1(
	input clk_50M,
	input reset_n,
	input [7:0] write_value,
	input write,
	output uart_txd,
	
	input uart_rxd,
	output read_error,
	output read_complete,
	output [7:0] read_value,
	
	output tick,
	output run,
	output start,
	output [3:0] ticked,
	
	output [7:0]  tx_data,
	output [10:0] out_data,
	output [10:0] data,
	output [3:0] ticked_r
);
	
	//// The Transmit Part ////
	
	//wire start;
	//wire [7:0] tx_data;
	write_latch dataInput(
		
		//Basics
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		
		//Write_Inputs
		.write(write),		
		.write_data(write_value),
		
		//Outputs
		.start(start),
		.tx_data(tx_data)
	);
	
	//wire tick;
	tx_time_gen alt_clk(
		
		//Basics
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		
		//Timer Start
		.start(start),
		
		//Pulse
		.tick(tick),
		
		.ticked(ticked),
		
		.count(run)
		
	);
	
	uart_txd_ctrl transmit_control(
		
		//Basics
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		
		//Tx_Input
		.tx_data(tx_data),
		
		//Pulse
		.tick(tick),
		
		//Load_Enable
		.start(start),
		
		//Data_Output
		.out(uart_txd),
		
		.out_data(out_data),
		.data(data)
		
	);
	
	
	//// The Receive Part ////
	wire tick_r;
	rx_time_gen timer(
		
		//Basics
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		
		//start && full -> start
		.start(uart_rxd),
		
		//Timer
		.tick(tick_r),
		
		
		.ticked(ticked_r),
		
		
		.full(read_complete)
		
	);
	
	uart_rxd_ctrl receive_control(
		
		//Basics
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		
		.tick(tick_r),
		
		.uart_rxd(uart_rxd),
		
		.read_value(read_value),
		
		.read_error(read_error),
		
		.full(read_complete)
		
	);

endmodule 