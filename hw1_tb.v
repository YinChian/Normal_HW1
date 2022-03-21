`timescale 1ns/1ns

module hw1_tb;

//parameter BIT_PERIOD      = 8680; // (1/115200)*1000000000
parameter BIT_PERIOD      = 104166; // (1/9600)*1000000000

reg clk_50M;
reg reset_n;
reg write;
reg [7:0] write_value;
wire	uart_txd;
reg [8:0] RX_Serial;
wire parity_check;

reg uart_rxd; 
reg  [3:0] j;
reg  parity;

integer ii;
wire read_error;
wire read_complete;
wire [7:0] read_value;

wire tick;
wire run;

hw1 u1 (
    .clk_50M(clk_50M),
    .reset_n(reset_n),
    .write(write),
    .write_value(write_value),
    .uart_txd(uart_txd),
    
    .read_complete(read_complete),
    .read_error(read_error),
    .read_value(read_value),
    .uart_rxd(uart_rxd),
	 
	 //Debug
	 .tick(tick),
	 .run(run)
    );

always
  #10 clk_50M = ~clk_50M;
  
initial
  begin
  reset_n = 0;  
  write = 0;
  write_value = 8'h12;
  clk_50M = 0 ;  
  RX_Serial = 9'h000;  
  uart_rxd = 1'b1;
  
  #30 reset_n = 1;
  
  #205 write = 1;
  #512 write = 0;
  #1500_000
  
  write_value = 8'h34;
  #345 write = 1;
  #273 write = 0;
  #1400_000
  
  write_value = 8'h56;
  #445 write = 1;
  #173 write = 0;
  #2500_000
      
      
  send_uart(8'h78);  
  #1200_000    
  
  send_uart(8'h9A);  
  #1200_000 
  
  send_uart(8'hBC);  
  #1200_000
  
  send_uart_parity_error(8'hDE);
  #1200_000
  //$finish;
  $stop;
  end
  
assign parity_check = RX_Serial[8]^RX_Serial[7]^RX_Serial[6]^RX_Serial[5]^RX_Serial[4]^RX_Serial[3]^RX_Serial[2]^RX_Serial[1]^RX_Serial[0];
  
always@(posedge clk_50M)
 begin       
     wait(write == 1);       // wait write pulse  
     wait(write == 0);
     wait(uart_txd == 0);    // wait start bit
      
      #(BIT_PERIOD);
      #(BIT_PERIOD/2);      
      
      // receive Data Byte          
      for (ii=0; ii<9; ii=ii+1)
        begin
          RX_Serial[ii] <= uart_txd;        
          #(BIT_PERIOD);
        end    
      if(parity_check)          
        $display("time = %3d,uart_rx data = %X ,parity = %X (Fail)",$time, RX_Serial[7:0],RX_Serial[8]);      // parity fail
      else  
        $display("time = %3d,uart_rx data = %X ,parity = %X (OK)",$time, RX_Serial[7:0],RX_Serial[8]); 
 end
 
always@(posedge clk_50M)
 begin 
 wait(read_complete == 1);
  begin
  $display("time = %3d,read_value = %X,read_error = %X,read_complete = %X",$time,read_value,read_error,read_complete);
  end
 wait(read_complete == 0); 
 end 

always@(posedge clk_50M)
 begin 
 wait(write == 1);
  begin
  $display("time = %3d,reset_n = %d,write = %d,write_value = %X",$time,reset_n,write,write_value);
  end
 wait(write == 0); 
 end  


  
task send_uart; 
 input [7:0] data;  
 begin  
  parity = data[0]^data[1]^data[2]^data[3]^data[4]^data[5]^data[6]^data[7];  // even parity bit
  $display("time = %3d,send_uart data = %X ,parity = %X",$time, data ,parity); 
  uart_rxd = 1'b0;  // start bit
  #(BIT_PERIOD);
  
  for(j=0;j<8;j=j+1) 
   begin             
   uart_rxd = data[j];   // data bit
  
   #(BIT_PERIOD);   
   end 
   
  uart_rxd = parity;  
  #(BIT_PERIOD);
   
  uart_rxd = 1'b1;  // stop bit 
  #(BIT_PERIOD); 
 end 
endtask  

task send_uart_parity_error; 
 input [7:0] data;  
 begin  
  parity = ~(data[0]^data[1]^data[2]^data[3]^data[4]^data[5]^data[6]^data[7]);  // error parity bit
  $display("time = %3d,send_uart data = %X ,parity = %X",$time, data ,parity); 
  uart_rxd = 1'b0;  // start bit
  #(BIT_PERIOD);
  
  for(j=0;j<8;j=j+1) 
   begin             
   uart_rxd = data[j];   // data bit
  
   #(BIT_PERIOD);   
   end 
   
  uart_rxd = parity;  
  #(BIT_PERIOD);
   
  uart_rxd = 1'b1;  // stop bit 
  #(BIT_PERIOD); 
 end 
endtask  
  
endmodule