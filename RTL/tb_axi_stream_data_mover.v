/*	written by		:	Mohamed S. Helal 
	date created		: 	feb, 15th, 2025
	description		:	test for axi stream data mover: connects source to destination 
						via a single axi-Lite channel 
	version			:	0.0
*/
module tb_axi_stream_data_mover;
//simulation parameters
	parameter HALF_CLOCK = 5, RST_PERIODE = 2, CYCLE = 2*HALF_CLOCK;

//stimulus signals
	reg				clk;
	reg				reset_n;
	
	//AXIS Input
	reg		[31:0]	s_axis_tdata;		//
	reg				s_axis_tvalid;      //	connected to source (transmitting module)
	wire			s_axis_tready;      //
	
	//AXIS Output
	wire	[31:0]	m_axis_tdata;		//
	wire			m_axis_tvalid;      //	connected to destination (recieving module)
	reg				m_axis_tready;      //

//DUT
	axi_stream_data_mover DUT (
	.clk				(clk		  ),
	.reset_n			(reset_n	  ),
	.s_axis_tdata		(s_axis_tdata ),
	.s_axis_tvalid   	(s_axis_tvalid),
	.s_axis_tready   	(s_axis_tready),
	.m_axis_tdata    	(m_axis_tdata ),
	.m_axis_tvalid   	(m_axis_tvalid),
	.m_axis_tready   	(m_axis_tready)
	);

//driver
initial begin
	//signal initialization
	clk = 0;
	reset_n = 0;
	s_axis_tdata = 32'bx;
	s_axis_tvalid = 1'bx;
	m_axis_tready = 1'bx;
	
	//global reset
	reset_n = 0;
	#RST_PERIODE
	reset_n = 1;
	#(CYCLE - RST_PERIODE);// now on the first negative edge

	//driving sequence
	//case 1 : source wants to send data master is ready
	s_axis_tdata = 32'hABCDEEFF;
	s_axis_tvalid = 1'b1;
	m_axis_tready = 1'b1;
	#(CYCLE);
	s_axis_tvalid = 1'b0;
	#(2*CYCLE);
	
	//case 2 : source wants to send data master is not ready (valid not ready)
	s_axis_tdata = 32'hDCBA0000;
	s_axis_tvalid = 1'b1;
	m_axis_tready = 1'b0;
	#(CYCLE);
	s_axis_tvalid = 1'b0;
	#(5*CYCLE);				//100 time units
	
	//case 3 : source waiting to send data master is now ready (valid and ready)
	m_axis_tready = 1'b1;
	#(1*CYCLE);
	m_axis_tready = 1'b0;
	#(2*CYCLE);
	
	//case 1 : source wants to send data master is ready
	s_axis_tdata = s_axis_tdata + 1;
	s_axis_tvalid = 1'b1;
	m_axis_tready = 1'b1;
	#(2*CYCLE);
	s_axis_tdata = s_axis_tdata + 1;
	m_axis_tready = 1'b0;
	#CYCLE;
	s_axis_tdata = s_axis_tdata + 1;
	m_axis_tready = 1'b1;
	#(1*CYCLE);
	s_axis_tdata = s_axis_tdata + 1;
	m_axis_tready = 1'b0;
	#(2*CYCLE);
	s_axis_tdata = s_axis_tdata + 1;
	m_axis_tready = 1'b1;
	#(1*CYCLE);
	s_axis_tdata = s_axis_tdata + 1;
	m_axis_tready = 1'b0;
	#(20*CYCLE);
	s_axis_tdata = s_axis_tdata + 1;
	#(1*CYCLE);
	s_axis_tdata = s_axis_tdata + 1;
	m_axis_tready = 1'b0;
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