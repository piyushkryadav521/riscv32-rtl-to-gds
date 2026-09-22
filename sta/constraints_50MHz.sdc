# ============================================================
# RV32I Processor - 50 MHz Timing Constraints
# ============================================================

# 20 ns clock = 50 MHz
create_clock -name clk -period 20.0 [get_ports clk]

# Clock uncertainty
set_clock_uncertainty 0.1 [get_clocks clk]

# Reset input
set_input_delay 1.0 -clock clk [get_ports reset]

# Output delays
set_output_delay 1.0 -clock clk [get_ports pc]
set_output_delay 1.0 -clock clk [get_ports instruction]

# Asynchronous reset
set_false_path -from [get_ports reset]