module shift_reg_sipo( //Serial in Parallel out
	input clk_50M,
	input reset_n,
	input uart_rxd,			//RxD input
	input tick,					//9600Hz input
	output [7:0] data_out,	//Data Captured
	output priority_bit		//Data Captured Priority Bit

);
	
	reg [10:0] data;
	
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) data <= 11'd0;
		else if(tick)data <= {uart_rxd,data[10:1]};
		else data <= data;
	end
	
	assign data_out = data[8:1];
	assign priority_bit = data[9];
	
	
	
	
endmodule 