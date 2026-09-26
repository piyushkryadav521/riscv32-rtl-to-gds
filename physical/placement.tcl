# ============================================================
# RV32I Processor - Standard Cell Placement
# Technology: Nangate45
# ============================================================

read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef

read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

# Load and link synthesized netlist
read_verilog sta/netlist/riscv32_nangate45.v
link_design top

# Timing / wire RC estimation
set_wire_rc -layer metal3

# Recreate Day 38 floorplan
initialize_floorplan \
    -utilization 60 \
    -aspect_ratio 1.0 \
    -core_space 10 \
    -site FreePDK45_38x28_10R_NP_162NW_34O

# Recreate routing tracks
make_tracks metal2 \
    -x_pitch 0.19 \
    -y_pitch 0.19 \
    -x_offset 0.095 \
    -y_offset 0.07

make_tracks metal3 \
    -x_pitch 0.14 \
    -y_pitch 0.14 \
    -x_offset 0.095 \
    -y_offset 0.07

# Place IO pins
place_pins \
    -hor_layers metal3 \
    -ver_layers metal2

# Global placement
global_placement \
    -density 0.60 \
    -timing_driven

# Detailed placement
detailed_placement

# Placement legality check
check_placement -verbose

# Reports
report_design_area

# Save placed design
write_def physical/rv32i_placed.def

exit
