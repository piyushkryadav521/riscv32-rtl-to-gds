# ============================================================
# RV32I Processor - Day 42 Global Routing
# Technology: Nangate45
# ============================================================

read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef
read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

read_def physical/rv32i_tracks_all.def

read_sdc sta/constraints_50MHz.sdc

set_wire_rc -layer metal3

global_route \
    -guide_file physical/rv32i_global_route.guide \
    -congestion_report_file sta/reports/global_route_congestion.rpt \
    -congestion_report_iter_step 1 \
    -congestion_iterations 50

report_checks \
    -path_delay max \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/global_route_setup.txt

report_checks \
    -path_delay min \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/global_route_hold.txt

report_worst_slack \
    > sta/reports/global_route_worst_slack.txt

report_tns \
    > sta/reports/global_route_tns.txt

report_design_area \
    > sta/reports/global_route_area.txt

write_def physical/rv32i_global_route.def

exit
