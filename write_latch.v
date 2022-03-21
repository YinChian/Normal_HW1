module write_latch(
	input clk_50M,
	input reset_n,
	input write,
	input [7:0] write_data,
	output start,
	output [7:0] tx_data
);
	
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) begin
			tx_data <= 8'h00;
			start <= 1'b0;
		end
		else if(write)begin
			tx_data <= write_data;
			start <= 1'b1;
		end
		else begin
			tx_data <= tx_data;
			start <= start //Not Sure
		end
	end
	
	
endmodule
