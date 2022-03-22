module transmittify(
	input clk_50M,
	input reset_n,
	input valid_i,
	input [7:0] orig_data,
	output reg [10:0] out_data,
	output reg valid_o
);
	
	always@(*)begin
		out_data = {1'b1,^orig_data,orig_data,1'b0};
	end
	
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) valid_o <= 1'b0;
		else if(out_data == {1'b1,^orig_data,orig_data,1'b0}) valid_o <= 1'b1;
		else valid_o <= 1'b0;
	end
	

endmodule