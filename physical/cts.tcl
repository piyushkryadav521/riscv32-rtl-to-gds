# ============================================================
# Reports
# ============================================================

report_clock_skew \
    > sta/reports/cts_clock_skew.txt

report_checks \
    -path_delay max \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/cts_setup.txt

report_checks \
    -path_delay min \
    -fields {slew cap input_pins nets fanout} \
    -digits 3 \
    > sta/reports/cts_hold.txt

report_worst_slack \
    > sta/reports/cts_worst_slack.txt

report_tns \
    > sta/reports/cts_tns.txt

# ============================================================
# Save CTS result
# ============================================================

write_def physical/rv32i_cts.def

exit