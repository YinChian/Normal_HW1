module tx_time_gen(
	input clk_50M,
	input reset_n,
	input start,		//Input for Trigger Counter
	output reg tick	//9600Hz output for tx
);	
		reg [3:0] ticked;
		reg count_enable;
		reg [12:0] counter;
		always@(posedge clk_50M,negedge reset_n)begin
			if(!reset_n) counter <= 13'd0;
			else if(count_enable)begin	//count_enable
				if(counter == 13'd5208)	counter <= 13'd0;
				else counter <= counter + 13'd1;
			end 
			else begin
				counter <= counter;
			end
		end
	
		always@(posedge clk_50M,negedge reset_n)begin
			if(!reset_n) tick <= 1'b0;
			else if(counter == 13'd5208) tick <= 1'b1;
			else tick <= 1'b0;
		end	
		
		//Monitoring
		always@(posedge clk_50M,negedge reset_n)begin
			if(!reset_n) ticked <= 4'd0;
			else if(ticked == 4'd11) ticked <= 4'd0;
			else if(tick) ticked <= ticked + 4'd1;
			else if(start) ticked <= 4'd0;
			else ticked <= ticked;
		end 
		
		always@(posedge clk_50M,negedge reset_n)begin
			if(!reset_n) count_enable <= 1'b0;
			else if(ticked == 4'd11) count_enable <= 1'b0;
			else if(start) count_enable <= 1'b1;
			else count_enable <= count_enable;
		end
		
		
endmodule