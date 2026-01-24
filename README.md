# Modular Cable Organizer

A wall-mountable, modular cable organizer system designed for 3D printing (PLA+).

## Project Structure

```
CableRack/
├── parameters.scad      # Central configuration (dimensions, tolerances)
├── main.scad            # Combined view for testing/visualization
├── insert_blank.scad    # Blank insert module (test piece)
├── frame_single.scad    # Single-slot test frame
├── ReferenceImages/     # Design reference blueprints
└── README.md            # This file
```

## Development Phases

### Phase 1: Core Mechanism Testing (Current)
- [x] Parameters file
- [x] Blank insert with snap tabs
- [x] Single-slot test frame
- [ ] Print and test fit

### Phase 2: Connector Testing
- [ ] Refine tolerances after test print
- [ ] USB-C insert

### Phase 3: Full Frame
- [ ] Multi-slot parametric grid
- [ ] Wall mounting holes

### Phase 4: Insert Library
- [ ] USB-A, Mini, Micro, Lightning
- [ ] HDMI, USB-B, 3.5mm jack
- [ ] Blank/label plate

## Print Settings (Recommended)

| Setting | Value |
|---------|-------|
| Material | PLA+ |
| Layer Height | 0.2mm |
| Nozzle | 0.4mm |
| Infill | 20-30% |
| Walls | 3 perimeters |
| Supports | None needed |

## Test Print Instructions

### Step 1: Export STL Files

Open each file in OpenSCAD and export:

```bash
# From terminal (or use OpenSCAD GUI: File > Export > STL)
cd /path/to/CableRack
openscad -o insert_blank.stl insert_blank.scad
openscad -o frame_single.stl frame_single.scad
```

### Step 2: Print Test Pieces

1. Print `frame_single.stl` - flat side down
2. Print `insert_blank.stl` - base down

### Step 3: Test Fit

1. Insert should drop into frame with slight resistance
2. Snap tabs should click into grooves
3. Insert should be removable with firm pull

### Step 4: Adjust Tolerances

If fit is too tight/loose, edit `parameters.scad`:
- `clearance` - increase if too tight, decrease if loose
- `snap_width` - wider for more secure snap
- `snap_overhang` in insert - more protrusion = tighter snap

## Key Dimensions

| Parameter | Value | Description |
|-----------|-------|-------------|
| Slot size | 35mm × 35mm | Interior frame slot |
| Insert base | 34.6mm × 34.6mm | With 0.2mm clearance |
| Frame depth | 10mm | Z height |
| Insert height | 25mm | Raised for cable clearance |
| Clearance | 0.2mm | Standard FDM tolerance |

## Viewing in OpenSCAD

Open `main.scad` for a combined view. Toggle display options at top of file:

```openscad
show_frame = true;      // Show frame
show_insert = true;     // Show insert  
show_assembled = false; // true = assembled position
```

## License

Personal/educational use.
