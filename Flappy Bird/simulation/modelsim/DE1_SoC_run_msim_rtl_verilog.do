transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/DE1_Soc.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/LFSR.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/pipe_generator.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/bird.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/pipeShift.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/activate.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/led_matrix_driver.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/clock_divider.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/crash.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/hex.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 6/lab\ 6 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 6/lab 6/D_FF.sv}

