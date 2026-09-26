# ============================================================
# RV32I Processor - Post-Placement Timing Analysis
# Technology: Nangate45
# Clock: 50 MHz
# ============================================================

# ------------------------------------------------------------
# Read technology LEF
# ------------------------------------------------------------

read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef

# ------------------------------------------------------------
# Read timing library
# ------------------------------------------------------------

read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

# ------------------------------------------------------------
# Load the completed placed design
# ------------------------------------------------------------

read_def physical/rv32i_placed.def

# ------------------------------------------------------------
# Wire RC estimation
# ------------------------------------------------------------

set_wire_rc -layer metal3

# ------------------------------------------------------------
# Timing constraints
# ------------------------------------------------------------

read_sdc sta/constraints_50MHz.sdc

# ------------------------------------------------------------
# Timing reports
# ------------------------------------------------------------

report_checks \
    -path_delay max \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/post_place_setup.txt

report_checks \
    -path_delay min \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/post_place_hold.txt

# ------------------------------------------------------------
# Timing summary
# ------------------------------------------------------------

report_worst_slack \
    > sta/reports/post_place_worst_slack.txt

report_tns \
    > sta/reports/post_place_tns.txt

# ------------------------------------------------------------
# Area
# ------------------------------------------------------------

report_design_area \
    > sta/reports/post_place_area.txt

exit