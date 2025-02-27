/*	written by		:	Mohamed S. Helal 
	date created		: 	feb, 15th, 2025
	description		:	axi stream data mover: connects source to destination 
						via a single axi-Lite channel 
	version			:	0.0
*/

module axi_stream_data_mover (
input	wire			clk,
input	wire			reset_n,

//AXIS Input
input	wire	[31:0]	s_axis_tdata,		//
input	wire			s_axis_tvalid,      //	connected to source (transmitting module)
output	wire			s_axis_tready,      //

//AXIS Output
output	wire	[31:0]	m_axis_tdata,		//
output	wire			m_axis_tvalid,      //	connected to destination (recieving module)
input	wire			m_axis_tready      //
);

reg	[31:0]	data_reg;
reg			data_valid;

always@(posedge clk,negedge reset_n)
begin
	if(!reset_n)
	begin
		data_reg <= 32'd0;
		data_valid <= 1'b0;
	end
	else if(s_axis_tvalid && s_axis_tready)		//slave sending valid data and stream is ready
	begin
		data_reg <= s_axis_tdata;					// register the data 
		data_valid <= 1'b1;							// and the valid flag
	end
	else if(m_axis_tvalid && m_axis_tready)		//master is ready and stream IS sending valid data
	begin											//master has successfully captured 
		data_valid <= 1'b0;							//the data so remove the valid
	end
end

assign m_axis_tdata		= data_reg;
assign m_axis_tvalid	= data_valid;

//s_axis_tready logic: recieve new data to send only after a reset 
//	or when the last transaction is completed (valid and ready)
assign s_axis_tready = !data_valid || (m_axis_tvalid && m_axis_tready);

endmodule
