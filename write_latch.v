module write_latch(
	input clk_50M,
	input reset_n,
	input write,
	input [7:0] write_data,
	output start,
	output [7:0] tx_data
);
	
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) tx_data <= 8'd0;
		else if(write) tx_data <= write_data;
		else tx_data <= tx_data;
	end
	
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) start <= 1'b0;
		else if(tx_data == write_data) start <= 1'b1;
		else start <= 1'b0;
	end
	
endmodule
