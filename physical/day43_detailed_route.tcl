read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef
read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

read_def physical/rv32i_global_route.def
read_guides physical/rv32i_global_route.guide

set_routing_layers \
    -signal metal2-metal10 \
    -clock metal2-metal10

detailed_route \
    -output_drc sta/reports/day43_detailed_route.drc

write_def physical/rv32i_detailed_route.def
