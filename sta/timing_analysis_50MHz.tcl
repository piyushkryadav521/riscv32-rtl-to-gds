# ============================================================
# RV32I Processor - 50 MHz OpenSTA Analysis
# Day 36
# ============================================================

read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

read_verilog sta/netlist/riscv32_nangate45.v

link_design top

read_sdc sta/constraints_50MHz.sdc

report_checks -path_delay max -format full_clock_expanded

report_checks -path_delay min -format full_clock_expanded

report_clock_skew

report_worst_slack -max
report_worst_slack -min

report_tns

exit