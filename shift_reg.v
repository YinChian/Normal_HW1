module shift_reg(
	input clk_50M,
	input reset_n,
	input enable,
	input d_in,
	input [10:0] load,
	input load_en,
	output [10:0] data_out,
	output out
);
	reg [11:0] data;
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) data <= 12'h000;
		else if(load_en) data <= load;
		else if(enable) data <= {d_in,data[11:1]};
		else data <= data;
	end
	
	assign {data_out,out} = data;
endmodule 