onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 40 /axi4_lite_tb/DUT/clk
add wave -noupdate -height 40 /axi4_lite_tb/DUT/reset_n
add wave -noupdate -height 40 -expand -group aw -color Pink -height 40 /axi4_lite_tb/DUT/awaddr
add wave -noupdate -height 40 -expand -group aw -color Pink -height 40 /axi4_lite_tb/DUT/awvalid
add wave -noupdate -height 40 -expand -group aw -height 40 /axi4_lite_tb/DUT/awready
add wave -noupdate -expand -group w -color Pink -height 40 /axi4_lite_tb/DUT/wdata
add wave -noupdate -expand -group w -color Pink -height 40 /axi4_lite_tb/DUT/wvalid
add wave -noupdate -expand -group w -height 40 /axi4_lite_tb/DUT/wready
add wave -noupdate -expand -group bResp -color Pink -height 40 /axi4_lite_tb/DUT/bready
add wave -noupdate -expand -group bResp -height 40 /axi4_lite_tb/DUT/bvalid
add wave -noupdate -group ar -color Pink -height 40 /axi4_lite_tb/DUT/araddr
add wave -noupdate -group ar -color Pink -height 40 /axi4_lite_tb/DUT/arvalid
add wave -noupdate -group ar -height 40 /axi4_lite_tb/DUT/arready
add wave -noupdate -expand -group r -height 40 /axi4_lite_tb/DUT/rdata
add wave -noupdate -expand -group r -height 40 /axi4_lite_tb/DUT/rvalid
add wave -noupdate -expand -group r -color Pink -height 40 /axi4_lite_tb/DUT/rready
add wave -noupdate -expand -group {timer core} -height 40 /axi4_lite_tb/DUT/load_value
add wave -noupdate -expand -group {timer core} -height 40 /axi4_lite_tb/DUT/start
add wave -noupdate -expand -group {timer core} -height 40 /axi4_lite_tb/DUT/stop
add wave -noupdate -expand -group {timer core} -color Pink -height 40 /axi4_lite_tb/DUT/expired
add wave -noupdate -expand -group {axi regs} -height 40 /axi4_lite_tb/DUT/awaddr_reg
add wave -noupdate -expand -group {axi regs} -height 40 /axi4_lite_tb/DUT/araddr_reg
add wave -noupdate -expand -group {axi regs} -height 40 /axi4_lite_tb/DUT/awaddr_waiting
add wave -noupdate -expand -group {axi regs} -height 40 /axi4_lite_tb/DUT/araddr_waiting
add wave -noupdate -expand -group {internal regs} -height 40 /axi4_lite_tb/DUT/load_reg
add wave -noupdate -expand -group {internal regs} -height 40 /axi4_lite_tb/DUT/control_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {119644 ps} 0}
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
WaveRestoreZoom {0 ps} {485266 ps}
