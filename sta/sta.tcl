# ============================================================
# RV32I Processor - OpenSTA Analysis
# ============================================================

read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

read_verilog sta/netlist/riscv32_nangate45.v

link_design top

read_sdc sta/sdcc.sdc

report_checks -path_delay max -format full_clock_expanded

report_checks -path_delay min -format full_clock_expanded

report_clock_skew

report_worst_slack -max
report_worst_slack -min

report_tns

exit
