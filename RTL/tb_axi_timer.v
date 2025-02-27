/*	written by		:	Mohamed S. Helal 
	date created	: 	feb, 25th, 2025
	description		:	testbench for AXI4-Lite hardware timer
						
	version			:	0.0
*/

`timescale 1ns/1ps

module tb_axi_timer;

// Clock and reset
reg clk;
reg reset_n;

// AXI4-Lite Write Channels
reg [31:0] awaddr;
reg awvalid;
wire awready;
reg [31:0] wdata;
reg wvalid;
wire wready;
reg bready;
wire bvalid;

// AXI4-Lite Read Channels
reg [31:0] araddr;
reg arvalid;
wire arready;
wire [31:0] rdata;
wire rvalid;
reg rready;

// Timer Core Signals
wire [31:0] load_value;
wire start, stop;
wire expired;

// Instantiate DUTs
timer_logic timer_DUT(
.clk		(clk		),
.reset_n	(reset_n	),
.start		(start		),
.stop		(stop		),
.load_value	(load_value	),
.expired	(expired	)
);

axi4_lite_if if_DUT (
    .clk(clk),
    .reset_n(reset_n),
    .awaddr(awaddr),
    .awvalid(awvalid),
    .awready(awready),
    .wdata(wdata),
    .wvalid(wvalid),
    .wready(wready),
    .bready(bready),
    .bvalid(bvalid),
    .araddr(araddr),
    .arvalid(arvalid),
    .arready(arready),
    .rdata(rdata),
    .rvalid(rvalid),
    .rready(rready),
    .load_value(load_value),
    .start(start),
    .stop(stop),
    .expired(expired)
);

// Clock generation
always #5 clk = ~clk;

// AXI Write Task (takes about t = 30)
task axi_write(input [31:0] addr, input [31:0] data);
    begin
        awaddr = addr;
        awvalid = 1;
        wdata = data;
        wait (awready);	
		@(posedge clk);	//ensure awvalid remains high for onecycle with awready
        awvalid = 0;
		//wait for addr to be registered
        wvalid = 1;
        wait (wready);
		@(posedge clk);	//ensure wvalid remains high for onecycle with wready
        wvalid = 0;
        bready = 1;
        wait (bvalid);
		@(posedge clk);	//ensure bvalid remains high for onecycle with bready
        bready = 0;
    end
endtask

// AXI Read Task
task axi_read(input [31:0] addr);
    begin
        araddr = addr;
        arvalid = 1;
        wait (arready);
		@(posedge clk);	//ensure arvalid remains high for onecycle with arready
        arvalid = 0;
		//wait for addr to be registered
        rready = 1;
        wait (rvalid);
		@(posedge clk);	//ensure rready remains high for onecycle with rvalid
        rready = 0;
    end
endtask

// intialization and reset driver
initial begin
    clk = 0;
    reset_n = 0;
    awaddr = 0;
    awvalid = 0;
    wdata = 0;
    wvalid = 0;
    bready = 0;
    araddr = 0;
    arvalid = 0;
    rready = 0;
    
    // Release reset
    #20 reset_n = 1;
end

// write driver block (starts at t=30)
initial begin
	#30; //start after reset sequence
	axi_write(32'h00,32'd5);	//load timer to 5 counts	(takes 4.5 cycles)
	axi_write(32'h04,32'd1);		//start the timer
	repeat(5)	@(posedge clk);		//wait five cycles

	axi_write(32'h00,32'd30);	//load timer to 5 counts	(takes 4.5 cycles)
	axi_write(32'h04,32'd1);		//start the timer
	axi_write(32'h04,32'd0);		//stop the timer
	
	#50;
end

// read driver block (starts at t=60)
initial begin
	#85; //start after reset sequence
	axi_read(32'h08);				//should read 0
	axi_read(32'h08);				//should read 0
	axi_read(32'h08);				//should read 1
end



//monitor block
initial begin
    // Monitor signals
    $monitor("Time=%0t | AWADDR=%h AWVALID=%b AWREADY=%b | WDATA=%h WVALID=%b WREADY=%b | BVALID=%b BREADY=%b | ARADDR=%h ARVALID=%b ARREADY=%b | RDATA=%h RVALID=%b RREADY=%b | START=%b STOP=%b EXPIRED=%b", 
             $time, awaddr, awvalid, awready, wdata, wvalid, wready, bvalid, bready, araddr, arvalid, arready, rdata, rvalid, rready, start, stop, expired);
    
    // End simulation after some time
    #500 $finish;
end


endmodule
