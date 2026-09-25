# ============================================================
# RV32I Processor - Floorplan
# Technology: Nangate45
# ============================================================

read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef

read_verilog sta/netlist/riscv32_nangate45.v

link_design top

read_sdc sta/constraints_50MHz.sdc

initialize_floorplan \
    -utilization 60 \
    -aspect_ratio 1.0 \
    -core_space 10 \
    -site FreePDK45_38x28_10R_NP_162NW_34O

make_tracks metal2 -x_pitch 0.19 -y_pitch 0.19 -x_offset 0.095 -y_offset 0.07
make_tracks metal3 -x_pitch 0.14 -y_pitch 0.14 -x_offset 0.095 -y_offset 0.07


place_pins \
    -hor_layers metal3 \
    -ver_layers metal2

write_def physical/rv32i_floorplan.def

report_design_area

exit
