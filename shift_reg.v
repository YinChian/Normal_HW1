module shift_reg(
	input CLK_50M,
	input RESET_N,
	input enabale,
	input d_in,
	output reg [10:0] data
);

	if(posedge CLK_50M,negedge RESET_N)begin
		if(!RESET_N) data <= 11'h000;
		else if(enable) begin
			data <= {d_in,data[10:1]};
		end else begin
			data <= data;
		end
	end
	
endmodule 