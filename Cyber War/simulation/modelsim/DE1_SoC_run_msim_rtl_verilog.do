transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/lab\ 5/lab5 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/lab 5/lab5/Display.sv}

