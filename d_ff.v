module d_ff(
	input clk,
	input reset_n,
	input d,
	output q
);
	
	always@(posedge clk,negedge reset_n)begin
		if(!reset) q <= 1'd0;
		else q <= d;
	end
	
endmodule 