#do file Car_Parking_System.vhd

quit -sim
vcom Car_Parking_System.vhd
vsim -t ns work.car_parking_system_vhdl(behavioral)


add wave -divider "Inputs:"
add wave -color "blue" clk
add wave -color "magenta" reset_n front_sensor back_sensor password_1 password_2


add wave -divider "Signals:"
add wave current_state next_state

add wave -divider "Outputs:"
add wave  -color "Forest Green"	GREEN_LED RED_LED


force clk 0 0, 1 {10 ns} -r 20
force reset_n 0
force front_sensor 0
force back_sensor 0
force password_1 00
force password_2 00
run 15 ns

force reset_n 1
force front_sensor 1
run 45 ns


force password_1 01
force password_2 10
run 35 ns

force back_sensor 1
run 30 ns

force front_sensor 0
run 20 ns


