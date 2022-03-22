module uart_rxd_ctrl(
	input clk_50M,
	input reset_n,
	input tick,		//9600Hz
	input uart_rxd,//RxD input
	
	input full,		//is Done
	output [7:0] read_value, //Value Received
	output read_error			 //Is Value Corrected
);

	wire [7:0] shift_entry;
	wire priority_bit;
	
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
	
	assign read_error = ^{priority_bit,read_value} & full;
	assign read_value = shift_entry & {8{full}};
	//assign read_value = shift_entry;
	
	
endmodule 