module uart_rxd_ctrl(
	input clk_50M,
	input reset_n,
	input tick,
	input uart_rxd,
	
	input full,
	
	output [7:0] read_value,
	output read_error
);

	
	wire [7:0] shift_entry;
	shift_reg_sipo shift_register(
		
		//Basics
		.clk_50M(clk_50M),
		.reset_n(reset_n),
		
		//Receive
		.uart_rxd(uart_rxd),
		
		//Tick
		.tick(tick),
		
		//received_data
		.data_out(shift_entry),
		.priority_bit(priority_bit)
		
	);
	
	assign read_error = ~^{priority_bit,read_value} & full;
	//assign read_value = shift_entry & {8{full}};
	assign read_value = shift_entry;
	
	
endmodule 