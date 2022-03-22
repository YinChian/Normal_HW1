transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/edge_detect.v}
vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/write_latch.v}
vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/tx_time_gen.v}
vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/transmittify.v}
vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/shift_reg.v}
vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/hw1.v}
vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/uart_txd_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/rx_time_gen.v}
vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/shift_reg_sipo.v}
vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/uart_rxd_ctrl.v}

vlog -vlog01compat -work work +incdir+D:/Digital_Logic_Design/Normal/Homework\ 1 {D:/Digital_Logic_Design/Normal/Homework 1/hw1_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  hw1_tb

add wave *
view structure
view signals
run -all
