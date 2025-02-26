onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 40 /axi4_lite_tb/DUT/clk
add wave -noupdate -height 40 /axi4_lite_tb/DUT/reset_n

# AXI Write Address (aw)
add wave -noupdate -expand -group aw -dividerColor Orange -color Pink -height 40 /axi4_lite_tb/DUT/awaddr
add wave -noupdate -expand -group aw -dividerColor Orange -color Pink -height 40 /axi4_lite_tb/DUT/awvalid
add wave -noupdate -expand -group aw -dividerColor Orange -height 40 /axi4_lite_tb/DUT/awready

# AXI Write Data (w)
add wave -noupdate -group w -dividerColor Blue -color Pink -height 40 /axi4_lite_tb/DUT/wdata
add wave -noupdate -group w -dividerColor Blue -color Pink -height 40 /axi4_lite_tb/DUT/wvalid
add wave -noupdate -group w -dividerColor Blue -height 40 /axi4_lite_tb/DUT/wready

# Write Response (bResp)
add wave -noupdate -group bResp -dividerColor Red -color Pink -height 40 /axi4_lite_tb/DUT/bready
add wave -noupdate -group bResp -dividerColor Red -height 40 /axi4_lite_tb/DUT/bvalid

# AXI Read Address (ar)
add wave -noupdate -group ar -dividerColor Green -color Pink -height 40 /axi4_lite_tb/DUT/araddr
add wave -noupdate -group ar -dividerColor Green -color Pink -height 40 /axi4_lite_tb/DUT/arvalid
add wave -noupdate -group ar -dividerColor Green -height 40 /axi4_lite_tb/DUT/arready

# Read Response (r)
add wave -noupdate -group r -dividerColor Cyan -height 40 /axi4_lite_tb/DUT/rdata
add wave -noupdate -group r -dividerColor Cyan -height 40 /axi4_lite_tb/DUT/rvalid
add wave -noupdate -group r -dividerColor Cyan -color Pink -height 40 /axi4_lite_tb/DUT/rready

# Timer Core Signals
add wave -noupdate -group {timer core} -dividerColor Purple -height 40 /axi4_lite_tb/DUT/load_value
add wave -noupdate -group {timer core} -dividerColor Purple -height 40 /axi4_lite_tb/DUT/start
add wave -noupdate -group {timer core} -dividerColor Purple -height 40 /axi4_lite_tb/DUT/stop
add wave -noupdate -group {timer core} -dividerColor Purple -color Pink -height 40 /axi4_lite_tb/DUT/expired

# AXI Registers
add wave -noupdate -group {axi regs} -dividerColor Magenta -height 40 /axi4_lite_tb/DUT/awaddr_reg
add wave -noupdate -group {axi regs} -dividerColor Magenta -height 40 /axi4_lite_tb/DUT/araddr_reg
add wave -noupdate -group {axi regs} -dividerColor Magenta -height 40 /axi4_lite_tb/DUT/awaddr_waiting
add wave -noupdate -group {axi regs} -dividerColor Magenta -height 40 /axi4_lite_tb/DUT/araddr_waiting

# Internal Registers
add wave -noupdate -group {internal regs} -dividerColor Yellow -height 40 /axi4_lite_tb/DUT/load_reg
add wave -noupdate -group {internal regs} -dividerColor Yellow -height 40 /axi4_lite_tb/DUT/control_reg

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 50
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {279255 ps}

