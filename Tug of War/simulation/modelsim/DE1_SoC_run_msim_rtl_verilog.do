transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 4/lab4 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 4/lab4/Lights.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 4/lab4 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 4/lab4/Winner.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 4/lab4 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 4/lab4/D_FF.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 4/lab4 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 4/lab4/DE1_SoC.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 4/lab4 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 4/lab4/Play.sv}

