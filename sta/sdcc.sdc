# ============================================================
# RV32I Processor - Static Timing Analysis Constraints
# Day 35
# ============================================================

# 10 ns clock = 100 MHz
create_clock -name clk -period 10.0 [get_ports clk]

# Clock uncertainty
set_clock_uncertainty 0.1 [get_clocks clk]

# Reset input delay
set_input_delay 1.0 -clock clk [get_ports reset]

# Output delays
set_output_delay 1.0 -clock clk [get_ports pc]
set_output_delay 1.0 -clock clk [get_ports instruction]

# Reset is asynchronous
set_false_path -from [get_ports reset]