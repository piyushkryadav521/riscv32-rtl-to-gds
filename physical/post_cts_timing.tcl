read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef
read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

read_def physical/rv32i_cts.def

set_wire_rc -layer metal3

read_sdc sta/constraints_50MHz.sdc

report_checks \
    -path_delay max \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/post_cts_setup.txt

report_checks \
    -path_delay min \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/post_cts_hold.txt

report_worst_slack \
    > sta/reports/post_cts_worst_slack.txt

report_tns \
    > sta/reports/post_cts_tns.txt

report_design_area \
    > sta/reports/post_cts_area.txt

exit
