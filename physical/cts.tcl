# ============================================================
# RV32I Processor - Clock Tree Synthesis
# Technology: Nangate45
# Clock: 50 MHz
# ============================================================

read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef

read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

read_def physical/rv32i_placed.def
read_sdc sta/constraints_50MHz.sdc

set_wire_rc -signal -layer metal3
set_wire_rc -clock  -layer metal5

# CTS configuration
set_cts_config \
    -wire_unit 20 \
    -root_buf CLKBUF_X3 \
    -buf_list CLKBUF_X3

clock_tree_synthesis \
    -root_buf CLKBUF_X3 \
    -buf_list CLKBUF_X3 \
    -repair_clock_nets \
    -no_insertion_delay

# Legalize CTS inserted cells
detailed_placement

# CTS reports
report_clock_skew \
    > sta/reports/cts_clock_skew.txt

report_checks \
    -path_delay max \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/cts_setup.txt

report_checks \
    -path_delay min \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/cts_hold.txt

report_worst_slack \
    > sta/reports/cts_worst_slack.txt

report_tns \
    > sta/reports/cts_tns.txt

check_placement -verbose

write_def physical/rv32i_cts.def

exit
