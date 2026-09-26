<<'EOF'
# Day 39 — Standard Cell Placement

## Objective

Perform global placement and detailed placement of the synthesized RV32I processor using OpenROAD and Nangate45 standard cells.

## Technology

- Technology: Nangate45
- Tool: OpenROAD
- OpenROAD version: 26Q3-1193-gec94b92b31
- Target utilization: 60%
- Placement density automatically adjusted by OpenROAD.

## Placement Flow

1. Load Nangate45 technology LEF.
2. Load Nangate45 standard-cell LEF.
3. Load Nangate45 Liberty timing library.
4. Read synthesized RV32I netlist.
5. Link the top-level design.
6. Configure wire RC estimation.
7. Recreate the Day 38 floorplan.
8. Create metal2 and metal3 routing tracks.
9. Place I/O pins.
10. Perform global placement.
11. Perform detailed placement.
12. Legalize the placement.
13. Check placement legality.
14. Export the placed DEF.

## Placement Results

- Core area: 131148.11 um^2
- Movable instance area: 80107.23 um^2
- Final utilization: 61.1%
- Placed cell area after timing repair: 89956.66 um^2
- Number of components: 31393
- Number of I/O pins: 66
- Initial placement violations: 287
- Final placement violations: 0
- Original HPWL: 269573.6 um
- Legalized HPWL: 333435.5 um
- Maximum displacement: 12.3 um

## Placement Status

Global placement completed after 501 iterations.

Detailed placement and legalization completed successfully.

Final placement legality:

```text
Illegal cells: 0
Illegal sites: 0
