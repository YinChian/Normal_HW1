module shift_reg(
	input clk_50M,
	input reset_n,
	input enable,			//9600Hz
	input [10:0] load,	//data for out
	input load_en,			//data load
	output out				//TxD output
	
);

	reg [10:0] data;
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) data <= 11'd0;
		else if(load_en) data <= load;
		else if(enable) data <= {1'b1,data[10:1]};
		else data <= data;
	end
	
	assign out = data[0];
	
endmodule 