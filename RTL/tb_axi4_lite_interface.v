`timescale 1ns / 1ps

module axi4_lite_tb;
    // Testbench Signals
    reg clk, reset_n;
    reg [31:0] awaddr, wdata;
    reg wvalid, bready;
    wire wready, bvalid;
    reg [31:0] araddr;
    reg rready;
    wire [31:0] rdata;
    wire rvalid;
    wire [31:0] load_value;
    wire start, stop;
    reg expired;

    // Instantiate DUT (Device Under Test)
    axi4_lite_interface dut (
        .clk(clk),
        .reset_n(reset_n),
        .awaddr(awaddr),
        .wdata(wdata),
        .wvalid(wvalid),
        .wready(wready),
        .bready(bready),
        .bvalid(bvalid),
        .araddr(araddr),
        .rdata(rdata),
        .rvalid(rvalid),
        .rready(rready),
        .load_value(load_value),
        .start(start),
        .stop(stop),
        .expired(expired)
    );

    // Clock Generation
    always #5 clk = ~clk; // 100MHz clock

    // Test Sequence
    initial begin
        // Initialize Signals
        clk = 0;
        reset_n = 0;
        awaddr = 0;
        wdata = 0;
        wvalid = 0;
        bready = 0;
        araddr = 0;
        rready = 0;
        expired = 0;
        
        // Apply Reset
        #10 reset_n = 1;

        // Test Case 1: Write Load Register (Address 0x00)
        #10 awaddr = 32'h00;
            wdata = 32'h12345678;
            wvalid = 1;
        #10 wvalid = 0;
        
        // Wait for Write Response
        #10 bready = 1;
        #10 bready = 0;
        
        // Test Case 2: Read Load Register (Address 0x00)
        #10 araddr = 32'h00;
            rready = 1;
        #15 rready = 0;

        // Test Case 3: Write Control Register (Address 0x04) to Start Timer
        #10 awaddr = 32'h04;
            wdata = 32'h01;
            wvalid = 1;
        #10 wvalid = 0;
        
        // Wait for Write Response
        #10 bready = 1;
        #10 bready = 0;
        
        // Test Case 4: Read Control Register (Address 0x04)
        #10 araddr = 32'h04;
            rready = 1;
        #15 rready = 0;

        // Test Case 5: Stop Timer (Write Control Register 0x04)
        #10 awaddr = 32'h04;
            wdata = 32'h00;
            wvalid = 1;
        #10 wvalid = 0;
        
        // Wait for Write Response
        #10 bready = 1;
        #10 bready = 0;
        
        // Test Case 6: Check if Timer Expired (Read 0x08)
        expired = 1;
        #10 araddr = 32'h08;
            rready = 1;
        #15 rready = 0;

        // End Simulation
        #50 $finish;
    end

    // Monitor Outputs
    initial begin
        $monitor("Time=%0t | wready=%b | bvalid=%b | rvalid=%b | rdata=0x%h | start=%b | stop=%b | expired=%b", 
                 $time, wready, bvalid, rvalid, rdata, start, stop, expired);
    end
endmodule
