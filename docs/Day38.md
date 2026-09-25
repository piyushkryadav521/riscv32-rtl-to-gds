# Day 38 — Physical Design Floorplanning

## Objective

Create the initial physical floorplan of the RV32I processor using OpenROAD and the Nangate45 technology.

## Technology

- Technology: Nangate45
- Standard-cell site: `FreePDK45_38x28_10R_NP_162NW_34O`
- Horizontal routing layer: metal3
- Vertical routing layer: metal2

## Floorplan Configuration

- Target utilization: 60%
- Aspect ratio: 1.0
- Core spacing: 10 µm
- I/O pin placement enabled

## Results

- Die area: 383.305 × 383.305 µm
- Core area: 131148.108 µm²
- Total instance area: 79193.786 µm²
- Effective utilization: 60.4%
- Number of instances: 30,877
- Number of I/O pins: 66
- Available I/O slots: 4,728
- I/O HPWL: 13062.88 µm

## Generated Files

- `physical/floorplan.tcl`
- `physical/rv32i_floorplan.def`

## Verification

Floorplan initialization completed successfully.

Placement rows were created successfully and all 66 I/O pins were assigned to sections.

The final DEF file was generated successfully.

## Day 38 Status

**COMPLETED**
