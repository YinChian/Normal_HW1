module transmitify(
	input clk_50M,
	input reset_n,
	input [7:0] orig_data,
	output reg [10:0] out_data
);
	
	always@(posedge clk,negedge reset_n)begin
		if(!reset_n) out_data <= 11'h000;
		else out_data <= {1'b0,orig_data[0],orig_data[1],orig_data[2],orig_data[3],orig_data[4],orig_data[5],orig_data[6],orig_data[7],^orig_data,1'b1};
	end

endmodule