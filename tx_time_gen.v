module tx_time_gen(
	input clk_50M,
	input reset_n,
	input start,
	output reg tick
);
		
		reg [12:0] counter;
		reg [3:0] sent_counter;
		reg count;
		
		//Count_Control - The counter
		always@(posedge clk_50M,negedge reset_n)begin
			if(!reset_n) sent_counter <= 4'd0;						  //reset
			else if(tick) sent_counter <= sent_counter + 4'd1;	  //tick = +1
			else if(sent_counter == 4'd11) sent_counter <= 4'd0; //carry_out
			else sent_counter <= sent_counter;						  //latch
		end
		
		//Count_Control - The Final Switch
		always@(posedge clk_50M,negedge reset_n)begin
			if(!reset_n) count <= 1'b0;
			else begin
				if(sent_counter == 4'd11) count <= 1'b0;				//count to 11 -> stop
				else if(start) count <= 1'b1;								//start signal ->run
				else count <= count;											//latch
			end			
		end
		
		//9600Hz_Counter
		always@(posedge clk_50M,negedge reset_n)begin
			if(!reset_n) counter <= 13'd0;								//reset
			else if(counter == 13'd5208)	counter <=  13'd0;		//carry_out
			else if(count) counter <= counter + 13'd1;				//count = +1
			else count <= count;												//latch
		end
		
		//9600Hz_Outputer
		always@(posedge clk_50M,negedge reset_n)begin
			if(!reset_n) tick <= 1'b0;
			else if(counter == 13'd5208) tick <= 1'b1;
			else tick <= 1'b0;
		end
		
		

endmodule