# ============================================================
# RV32I Processor - Standard Cell Placement
# Technology: Nangate45
# Day 39
# ============================================================

read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef

read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

read_def physical/rv32i_floorplan.def

# Global placement
global_placement \
    -density 0.60 \
    -timing_driven

# Detailed placement / legalization
detailed_placement

# Check placement legality
check_placement -verbose

# Reports
report_design_area

# Save placed design
write_def physical/rv32i_placed.def

exit