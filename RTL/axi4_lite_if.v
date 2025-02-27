/*	written by		:	Mohamed S. Helal 
	date created	: 	feb, 23rd, 2025
	description		:	AXI4-Lite interface for the hardware timer (timer_logic.v)
						
	version			:	0.1
*/

module axi4_lite_if (
	input	wire			clk,reset_n,
//axi write channels
	//address write
	input	wire 	[31:0]	awaddr,
	input	wire 			awvalid,
	output	reg 			awready,

	//data write
	input	wire 	[31:0]	wdata,
	input	wire 			wvalid,
	output	reg 			wready,

	//write response
	input	wire 			bready,
	output	reg 			bvalid,

//axi read channels
	//data write
	input	wire 	[31:0]	araddr,
	input	wire 			arvalid,
	output	reg 			arready,

	//data write
	output	reg 	[31:0]	rdata,
	output	reg 			rvalid,
	input	wire 			rready,
	
//timer core signals
	output	wire	[31:0]	load_value,
	output	reg				start,stop,
	input	wire			expired
);

//internal registers
reg	[31:0]		awaddr_reg,araddr_reg;
reg				awaddr_waiting,araddr_waiting;	

reg	[31:0]		load_reg;
reg				control_reg;

always@(posedge clk,negedge reset_n) begin
	if(!reset_n)
	begin
	//write channel regs
		awready 		    <= 1'b0;
		awaddr_reg 		  <= 32'b0;
		awaddr_waiting 	<= 1'b0;
		wready 		    	<= 1'b0;
		bvalid	 		    <= 1'b0;
	//read channel regs
		araddr_reg		<= 32'b0;
		araddr_waiting 	<= 1'b0;
		arready 		<= 1'b0;
		rdata	 		<= 32'b0;
		rvalid	 		<= 1'b0;
	//time core regs
		start 			<= 1'b0;
		stop	 		<= 1'b0;
		load_reg	 	<= 32'b0;
		control_reg	 	<= 1'b0;
	end
	
	else begin
		//write address logic :
		//when the master is trying 
		//to send aw transaction via awvalid assertion
		//if not occupied assert ready to complete 
		//the handshake for one cycle and register
		//the address, else keep ready deasserted
		if(awvalid && !awready )begin
			awready		<= 1'b1;
			awaddr_reg 	<= awaddr;
			awaddr_waiting <= 1'b1;
		end
		else begin
			awready <= 1'b0;
		end
		
		//write logic
		//start transaction the same cycle 
		//wready is asserted to complete the
		//hanshake
		wready <= wvalid && !wready;	//one-shot valid ready handshake
		if ( wvalid && !wready && awaddr_waiting)	//strat transaction
		begin
			case(awaddr_reg)
				32'h00:	load_reg <= wdata;
				32'h04:begin
					control_reg <= wdata[0];
					if(wdata[0])	start <= 1'b1;
					else			stop  <= 1'b1;
				end
			endcase
			//desetting the waiting address 
			//flag as transaction completed
			awaddr_waiting <= 1'b0;
			//and setting the write response
			//bvalid signal
			bvalid <= 1'b1;
		end
		//desetting one-shot start and stop signals
		if(start)	start <= 1'b0;
		if(stop )   stop  <= 1'b0;
		//desetting the bvalid signal on handshake
		if(bvalid && bready)	bvalid <= 1'b0;
		
		//read address logic
		if(arvalid && !arready) begin 
			arready <= 1'b1;
			araddr_reg <= araddr;
			araddr_waiting <= 1'b1;
		end
		else
		begin
			arready  <= 1'b0;	//deasserted after one cycle (handshake completed)
		end
		
		//read logic
		if(rready && !rvalid && araddr_waiting)	//transaction successful
		begin
			case(araddr_reg)
				32'h00:	rdata <= load_reg;
				32'h04:	rdata <= {31'b0,control_reg};
				32'h08: rdata <= {31'b0,expired};
				default: rdata <= 32'hDEADBEEF;
			endcase
			rvalid <= 1'b1;	//to complete the handshake
			araddr_waiting <= 1'b0;	//data is done read alright...,man!
		end
		//deassertions
		if (rvalid)	rvalid <= 1'b0;	//one-shot rvalid 
	end
end

assign load_value = load_reg;	//to the timer 

endmodule
