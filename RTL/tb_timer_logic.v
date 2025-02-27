/*	written by		:	Mohamed S. Helal 
	date created		: 	feb, 18th, 2025
	description		:	test for the hardware timer 
						(part of AXI4_Lite project) 
	version			:	0.0
*/
module tb_timer_logic;
//simulation parameters
	parameter HALF_CLOCK = 5, RST_PERIODE = 2, CYCLE = 2*HALF_CLOCK;

//stimulus signals	
	//timer input 
	reg				clk;
	reg				reset_n;
	reg		[31:0]	load_value;	
	reg				start;      
	reg				stop;     
	//timer Output
	wire			expired;
//DUT
timer_logic DUT (
	.clk		(clk		),
	.reset_n	(reset_n	),
	.start		(start		),
	.stop		(stop		),
	.load_value	(load_value	),
	.expired	(expired	)
	);

//driver
initial begin
	//signal initialization
	clk			= 1'b0;
	start		= 1'b0;
	stop		= 1'b0;
	load_value	= 32'd0;
	
	//global reset
	reset_n = 0;
	#RST_PERIODE
	reset_n = 1;
	#(CYCLE - RST_PERIODE);// now on the first negative edge

	//driving sequence
	//case 1 : start th timer with a load value of 12 and wait for the expired
	load_value	= 32'd12;
	stop		= 1'b0;
	start		= 1'b1;
	#(1*CYCLE);
	start		= 1'b0;
	#(15*CYCLE);
	
	//case 2 : load another value and start again waiting for expired
	load_value	= 32'd3;
	stop		= 1'b0;
	start		= 1'b1;
	#(1*CYCLE);
	start		= 1'b0;
	#(4*CYCLE);
	
	//case 3 : load another value and start and stop to hold the count
	load_value	= 32'd5;
	start		= 1'b1;
	#(1*CYCLE);
	start		= 1'b0;
	#(3*CYCLE);
	stop		= 1'b1;
	#(1*CYCLE);
	stop		= 1'b0;
	#(5*CYCLE);


	$stop;
end

//monitor
//initial	begin
//	$monitor(
//	clk		  	 ,
//	reset_n	     ,
//	s_axis_tdata ,
//	s_axis_tvalid,
//	s_axis_tready,
//	m_axis_tdata ,
//	m_axis_tvalid,
//	m_axis_tready
//	);
//end


//clock generator
always #HALF_CLOCK clk = ~clk;

endmodule