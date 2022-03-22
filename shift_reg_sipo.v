module shift_reg_sipo( //Serial in Parallel out
	input clk_50M,
	input reset_n,
	input uart_rxd,
	input tick,

	output [7:0] data_out,
	output priority_bit

);
	
	reg [10:0] data;
	
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) data <= 11'd0;
		else if(tick)data <= {uart_rxd,data[10:1]};
		else data <= data;
	end
	
	//assign data_out = {data[1],data[2],data[3],data[4],data[5],data[6],data[7],data[8]};
	assign data_out = data[8:1];
	assign priority_bit = data[9];
	
	/*
	//is 11 datas?
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) count <= 4'd0;
		else if(tick && count_en)begin
			if(count == 4'd11) count <= 4'd0;
			else count <= count + 4'd1;
		end else count <= count;
	end
	
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) count_en <= 1'd0;
		else if(count == 4'd11) count_en <= 1'd0;
		else if(!uart_rxd) count_en <= 1'd1;
		else count_en <= count_en;
	end
	
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) data_out <= 8'd0;
		else if(!count_en) data_out <={data[1],data[2],data[3],data[4],data[5],data[6],data[7],data[8]};
		else data_out <= data_out;
	end
	
	
	always@(posedge clk_50M,negedge reset_n)begin
		if(!reset_n) priority_bit <= 1'b0;
		else if(!count_en) priority_bit <= data[9];
		else priority_bit <= priority_bit;
	end
	//assign data_out = {data[1],data[2],data[3],data[4],data[5],data[6],data[7],data[8]};
	//assign data_out = data[8:1];
	//assign priority_bit = data[9];*/
	
	
	
endmodule 