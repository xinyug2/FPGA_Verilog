transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/Lab\ 3/Lab3 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/Lab 3/Lab3/DE1_SoC.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/Lab\ 3/Lab3 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/Lab 3/Lab3/seaTacLight.sv}
vlog -sv -work work +incdir+C:/Users/xinyu/OneDrive/Documents/EE\ 271/Lab/Lab\ 3/Lab3 {C:/Users/xinyu/OneDrive/Documents/EE 271/Lab/Lab 3/Lab3/clock_divider.sv}

