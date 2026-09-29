# ============================================================
# RV32I Processor - Day 42 Clean Routing Tracks
# Technology: Nangate45
# ============================================================

read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef
read_liberty ~/OpenROAD/test/Nangate45/Nangate45_typ.lib

read_def physical/rv32i_cts_opt_legal.def

# Metal 1
make_tracks metal1 \
    -x_pitch 0.14 \
    -y_pitch 0.14 \
    -x_offset 0.095 \
    -y_offset 0.07

# Metal 2
make_tracks metal2 \
    -x_pitch 0.28 \
    -y_pitch 0.28 \
    -x_offset 0.095 \
    -y_offset 0.07

# Metal 3
make_tracks metal3 \
    -x_pitch 0.28 \
    -y_pitch 0.28 \
    -x_offset 0.095 \
    -y_offset 0.07

# Metal 4
make_tracks metal4 \
    -x_pitch 0.28 \
    -y_pitch 0.28 \
    -x_offset 0.095 \
    -y_offset 0.07

# Metal 5
make_tracks metal5 \
    -x_pitch 0.28 \
    -y_pitch 0.28 \
    -x_offset 0.095 \
    -y_offset 0.07

# Metal 6
make_tracks metal6 \
    -x_pitch 0.28 \
    -y_pitch 0.28 \
    -x_offset 0.095 \
    -y_offset 0.07

# Metal 7
make_tracks metal7 \
    -x_pitch 0.8 \
    -y_pitch 0.8 \
    -x_offset 0.095 \
    -y_offset 0.07

# Metal 8
make_tracks metal8 \
    -x_pitch 0.8 \
    -y_pitch 0.8 \
    -x_offset 0.095 \
    -y_offset 0.07

# Metal 9
make_tracks metal9 \
    -x_pitch 1.6 \
    -y_pitch 1.6 \
    -x_offset 0.095 \
    -y_offset 0.07

# Metal 10
make_tracks metal10 \
    -x_pitch 1.6 \
    -y_pitch 1.6 \
    -x_offset 0.095 \
    -y_offset 0.07

write_def physical/rv32i_tracks_clean.def

exit
