/*	written by		:	Mohamed S. Helal 
	date created		: 	feb, 18th, 2025
	description		:	simple hardware countdown timer  
						(part of the AXI4-Lite project)
	version			:	0.0
*/
module timer_logic (
input 	wire			clk,
input 	wire			reset_n,
input 	wire			start,
input 	wire			stop,
input 	wire	[31:0]	load_value,
output	reg				expired
);

reg 			running;
reg	[31:0]		counter;

always@(posedge clk, negedge reset_n)
begin
	if(!reset_n)			//reset on negative edge 
	begin
		counter<= 32'b0;
		running <= 1'b0;
		expired <= 1'b0;	
	end
	else if(start)			//start pulse loads the timer and asserts running
	begin
		counter<= load_value;
		running <= 1'b1;
		expired <= 1'b0;			
	end
	else if(stop)			//stop the timer pauses the counter and deasserts running
	begin
		counter<= counter;
		running <= 1'b0;
		expired <= expired;			
	end
	else if(running)		//if running and counter = 0 deassert running and activate expired flag
	begin
		if(counter == 0)
		begin
			running <= 1'b0;
			expired <= 1'b1;
		end
		else					//else decrement 
		begin
			counter <= counter - 1'b1;
		end	
	end
end

endmodule