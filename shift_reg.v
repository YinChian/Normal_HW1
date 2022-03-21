module shift_reg(
	input CLK_50M,
	input RESET_N,
	input enabale,
	input d_in,
	input [10:0] load,
	input load_en,
	output reg [10:0] data
);
	
	if(posedge CLK_50M,negedge RESET_N)begin
		if(!RESET_N) data <= 11'h000;
		else if(load_en) data <= load;
		else if(enable) data <= {d_in,data[10:1]};
		else data <= data;
	end
	
endmodule 