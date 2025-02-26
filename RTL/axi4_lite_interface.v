/*	written by		:	Mohamed S. Helal 
	date created	: 	feb, 22th, 2025
	description		:	AXI4-Lite interface for the hardware timer (timer_logic.v)
						
	version			:	0.0
*/

module axi4_lite_interface (
input	wire			clk,reset_n,
//axi write channels
	//address write
	input	wire 	[31:0]	awaddr,
//	input	wire 			awvalid,
//	output	wire 			awready,

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
//	input	wire 			arvalid,
//	output	wire 			arready,

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
reg 	[31:0]	LOAD;
reg				CONTROL;


always@(posedge clk,negedge reset_n)
begin
	if(!reset_n)
	begin
		LOAD 	<= 32'd0;
		CONTROL <= 1'b0 ;
		start	<= 1'b0 ;
		stop	<= 1'b0 ;
		wready	<= 1'b0 ;
		bvalid	<= 1'b0 ;
		rvalid	<= 1'b0 ;
	end
	
	else
	begin
		//write logic
		//write transaction begins when
		//the master is sending a valid
		//address and a valid signal the wready 
		//is asserted for one cycle and transaction completes 
		//one-shot wready when valid is received
		wready <= wvalid && !wready;					
		if (wready) begin
			case(awaddr)
				32'h00:	LOAD <= wdata;
				32'h04:	begin
							CONTROL <= wdata[0];
							if(wdata[0]) 	start <= 1'b1;
							else			stop  <= 1'b1;
						end
			endcase
			//setting bvalid when a write occurs
			bvalid <= 1'b1;
		end
		if(bvalid && bready) bvalid <= 1'b0;	//desetting on handshake
		
		//clear one-shot start and stop 
		if(start) start <= 1'b0;
		if(stop)  stop 	<= 1'b0;
		
		//read logic
		//read transaction begins when 
		//the master is ready to receive 
		//and the slave is not occupied 
		//(not already sending valid data)
		if(rready && !rvalid) begin
			rvalid <= 1'b1;
			case(araddr)
				32'h00: rdata <= LOAD;
				32'h04: rdata <= {31'b0,CONTROL};
				32'h08: rdata <= {31'b0,expired};
			endcase
		end
		//clear rvalid on successful transaction
		if(rvalid && rready) rvalid <= 1'b0;
	end
end

assign load_value = LOAD;

endmodule