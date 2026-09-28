read_lef ~/OpenROAD/test/Nangate45/Nangate45_tech.lef
read_lef ~/OpenROAD/test/Nangate45/Nangate45.lef

read_def physical/rv32i_cts_opt.def

make_tracks metal1 \
    -x_pitch 0.14 \
    -y_pitch 0.14 \
    -x_offset 0.095 \
    -y_offset 0.07

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

make_tracks metal4 \
    -x_pitch 0.28 \
    -y_pitch 0.28 \
    -x_offset 0.095 \
    -y_offset 0.07

make_tracks metal5 \
    -x_pitch 0.28 \
    -y_pitch 0.28 \
    -x_offset 0.095 \
    -y_offset 0.07

make_tracks metal6 \
    -x_pitch 0.28 \
    -y_pitch 0.28 \
    -x_offset 0.095 \
    -y_offset 0.07

make_tracks metal7 \
    -x_pitch 0.8 \
    -y_pitch 0.8 \
    -x_offset 0.095 \
    -y_offset 0.07

make_tracks metal8 \
    -x_pitch 0.8 \
    -y_pitch 0.8 \
    -x_offset 0.095 \
    -y_offset 0.07

make_tracks metal9 \
    -x_pitch 1.6 \
    -y_pitch 1.6 \
    -x_offset 0.095 \
    -y_offset 0.07

make_tracks metal10 \
    -x_pitch 1.6 \
    -y_pitch 1.6 \
    -x_offset 0.095 \
    -y_offset 0.07

write_def physical/rv32i_tracks_all.def

exit
