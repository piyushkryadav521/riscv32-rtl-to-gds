read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef
read_def physical/rv32i_global_route_clean.def

puts "===== ROUTING LAYERS ====="
report_routing_layers

exit
