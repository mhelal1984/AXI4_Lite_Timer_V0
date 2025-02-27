/*	written by		:	Mohamed S. Helal 
	date created	: 	feb, 24th, 2025
	description		:	testbench for AXI4-Lite interface for the hardware timer (timer_logic.v)
						
	version			:	0.1
*/

`timescale 1ns/1ps

module axi4_lite_tb;

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
reg expired;

// Instantiate DUT
axi4_lite_if DUT (
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
    expired = 0;
    
    // Release reset
    #20 reset_n = 1;
end

// write driver block (starts at t=30)
initial begin
	#30; //start after reset sequence
	axi_write(32'h00,32'd5);	//write 5 to the load register
	// #20							//wait 2 cycles
	axi_write(32'h04,32'd1);		//start the count
	#(6*10)							//wait 6 cycles
	axi_write(32'h00,32'h0A7A);
	#50
	expired = 1;					//should write in the 0x08 reg 1
end

// read driver block (starts at t=60)
initial begin
	#60; //start after reset sequence
	axi_read(32'h00);	//should read 5 from the previous write
	#30							//wait 3 cycles
	axi_read(32'h04);				//should read 1
	#(20*10)							//wait 20 cycles
	axi_read(32'h08);				//should read 1
end



//monitor block
initial begin
    // Monitor signals
    $monitor("Time=%0t | AWADDR=%h AWVALID=%b AWREADY=%b | WDATA=%h WVALID=%b WREADY=%b | BVALID=%b BREADY=%b | ARADDR=%h ARVALID=%b ARREADY=%b | RDATA=%h RVALID=%b RREADY=%b | START=%b STOP=%b EXPIRED=%b", 
             $time, awaddr, awvalid, awready, wdata, wvalid, wready, bvalid, bready, araddr, arvalid, arready, rdata, rvalid, rready, start, stop, expired);
    
    // End simulation after some time
    #200 $finish;
end


endmodule
