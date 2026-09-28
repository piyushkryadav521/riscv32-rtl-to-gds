# ============================================================
# RV32I Processor - Day 42 Detailed Routing
# Technology: Nangate45
# ============================================================

read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef
read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

read_def physical/rv32i_global_route_clean.def

read_sdc sta/constraints_50MHz.sdc

set_wire_rc -layer metal3

# Routing Layer Configuration
set_routing_layers \
    -signal metal2-metal10 \
    -clock metal2-metal10

# Generate pin access information
pin_access

detailed_route \
    -output_drc sta/reports/detailed_route_drc.rpt \
    -output_guide_coverage sta/reports/detailed_route_guide_coverage.rpt \
    -droute_end_iter 64 \
    -verbose 1

write_def physical/rv32i_detailed_route.def

exit
