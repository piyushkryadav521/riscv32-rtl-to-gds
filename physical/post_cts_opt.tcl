# ============================================================
# RV32I Processor - Post-CTS Timing Optimization
# Technology: Nangate45
# Clock: 50 MHz
# ============================================================

read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef

read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

# Load post-CTS design
read_def physical/rv32i_cts.def

# Timing constraints
read_sdc sta/constraints_50MHz.sdc

# Wire RC estimation
set_wire_rc -layer metal3

# ============================================================
# Repair design
# ============================================================

repair_design \
    -max_wire_length 1000

# ============================================================
# Timing repair
# ============================================================

repair_timing \
    -setup \
    -hold \
    -max_passes 2 \
    -max_iterations 100

# ============================================================
# Reports
# ============================================================

report_checks \
    -path_delay max \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/post_cts_opt_setup.txt

report_checks \
    -path_delay min \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/post_cts_opt_hold.txt

report_worst_slack \
    > sta/reports/post_cts_opt_worst_slack.txt

report_tns \
    > sta/reports/post_cts_opt_tns.txt

report_design_area \
    > sta/reports/post_cts_opt_area.txt

# Save optimized design
write_def physical/rv32i_cts_opt.def

exit