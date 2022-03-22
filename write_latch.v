module write_latch(
	input clk_50M,
	input reset_n,
	input write,
	input [7:0] write_data,
	output start,
	output reg [7:0] tx_data
);
	
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) tx_data <= 8'd0;
		else if(start) tx_data <= write_data;
		else tx_data <= tx_data;
	end
	
	
	edge_detect detect(
		.clk(clk_50M),
		.rst_n(reset_n),
		.data_in(write),
		.pos_edge(start)
	);
	
	
endmodule
