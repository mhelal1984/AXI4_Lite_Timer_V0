onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 40 /tb_axi_timer/if_DUT/clk
add wave -noupdate -height 40 /tb_axi_timer/if_DUT/reset_n
add wave -noupdate -expand -group aw -color Pink -height 40 /tb_axi_timer/if_DUT/awaddr
add wave -noupdate -expand -group aw -color Pink -height 40 /tb_axi_timer/if_DUT/awvalid
add wave -noupdate -expand -group aw -height 40 /tb_axi_timer/if_DUT/awready
add wave -noupdate -expand -group w -color Pink -height 40 /tb_axi_timer/if_DUT/wdata
add wave -noupdate -expand -group w -color Pink -height 40 /tb_axi_timer/if_DUT/wvalid
add wave -noupdate -expand -group w -height 40 /tb_axi_timer/if_DUT/wready
add wave -noupdate -group bResp -color Pink -height 40 /tb_axi_timer/if_DUT/bready
add wave -noupdate -group bResp -height 40 /tb_axi_timer/if_DUT/bvalid
add wave -noupdate -expand -group ar -color Pink -height 40 /tb_axi_timer/if_DUT/araddr
add wave -noupdate -expand -group ar -color Pink -height 40 /tb_axi_timer/if_DUT/arvalid
add wave -noupdate -expand -group ar -height 40 /tb_axi_timer/if_DUT/arready
add wave -noupdate -expand -group r -height 40 /tb_axi_timer/if_DUT/rdata
add wave -noupdate -expand -group r -height 40 /tb_axi_timer/if_DUT/rvalid
add wave -noupdate -expand -group r -color Pink -height 40 /tb_axi_timer/if_DUT/rready
add wave -noupdate -group {timer core} -height 40 /tb_axi_timer/if_DUT/load_value
add wave -noupdate -group {timer core} -height 40 /tb_axi_timer/if_DUT/start
add wave -noupdate -group {timer core} -height 40 /tb_axi_timer/if_DUT/stop
add wave -noupdate -group {timer core} -color Pink -height 40 /tb_axi_timer/if_DUT/expired
add wave -noupdate -expand -group {axi regs} -height 40 /tb_axi_timer/if_DUT/awaddr_reg
add wave -noupdate -expand -group {axi regs} -height 40 /tb_axi_timer/if_DUT/araddr_reg
add wave -noupdate -expand -group {axi regs} -height 40 /tb_axi_timer/if_DUT/awaddr_waiting
add wave -noupdate -expand -group {axi regs} -height 40 /tb_axi_timer/if_DUT/araddr_waiting
add wave -noupdate -group {internal regs} -height 40 /tb_axi_timer/if_DUT/load_reg
add wave -noupdate -group {internal regs} -height 40 /tb_axi_timer/if_DUT/control_reg
add wave -noupdate -height 40 -expand -group {timer internal} /tb_axi_timer/timer_DUT/clk
add wave -noupdate -height 40 -expand -group {timer internal} /tb_axi_timer/timer_DUT/reset_n
add wave -noupdate -height 40 -expand -group {timer internal} /tb_axi_timer/timer_DUT/start
add wave -noupdate -height 40 -expand -group {timer internal} /tb_axi_timer/timer_DUT/stop
add wave -noupdate -height 40 -expand -group {timer internal} /tb_axi_timer/timer_DUT/load_value
add wave -noupdate -height 40 -expand -group {timer internal} /tb_axi_timer/timer_DUT/expired
add wave -noupdate -height 40 -expand -group {timer internal} /tb_axi_timer/timer_DUT/running
add wave -noupdate -height 40 -expand -group {timer internal} /tb_axi_timer/timer_DUT/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {198131 ps} 0}
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
WaveRestoreZoom {0 ps} {525 ns}
