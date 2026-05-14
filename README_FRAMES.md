# CableRack Frame Sizes

All frame files use the parameterized `frame_module.scad` and can be rendered with any row/column combination.

## Pre-configured Frame Sizes

| File | Size | Slots | Dimensions (approx) | Notes |
|------|------|-------|---------------------|-------|
| `print_frame_single.scad` | 1×1 | 1 | 48.5 × 32.5 mm | Minimal single slot |
| `print_frame_2x2.scad` | 2×2 | 4 | 80.5 × 48.5 mm | Original test size |
| `print_frame_4x4.scad` | 4×4 | 16 | 145 × 80.5 mm | Small rack |
| `print_frame_6x6.scad` | 6×6 | 36 | 209 × 112.5 mm | Medium rack |
| `print_frame_8x15.scad` | 8×15 | 120 | 275 × 256.5 mm | Large balanced rack |
| `print_frame_10x10.scad` | 10×10 | 100 | 340.5 × 176.5 mm | Wide rack |
| `print_frame_10x20.scad` | 10×20 | 200 | 340.5 × 336.5 mm | **Maximum for 350mm bed** |

## Custom Frame Sizes

Use `print_frame_CUSTOM.scad` to create any size:

1. Open `print_frame_CUSTOM.scad`
2. Edit the `cols` and `rows` values (lines 18-19)
3. Render and export to STL

### Frame Size Calculator

**Width** = (cols × 32.5) + 16 mm  
**Height** = (rows × 16.5) + 16 mm

### 350×350mm Bed Limits

- **Maximum columns:** 10 (340.5mm width)
- **Maximum rows:** 20 (345.5mm height)
- **Maximum slots:** 200 (10×20 grid)

## Examples for Common Bed Sizes

### 220×220mm bed (Ender 3, etc.)
- 6×12 grid → 209 × 208.5 mm (72 slots)
- 6×10 grid → 209 × 176.5 mm (60 slots)

### 250×250mm bed
- 7×14 grid → 243.5 × 241.5 mm (98 slots)
- 7×12 grid → 243.5 × 208.5 mm (84 slots)

### 300×300mm bed
- 8×17 grid → 275 × 296.5 mm (136 slots)
- 9×17 grid → 308.5 × 296.5 mm (153 slots)

### 350×350mm bed
- 10×15 grid → 340.5 × 256.5 mm (150 slots)
- 10×20 grid → 340.5 × 336.5 mm (200 slots) **MAXIMUM**

## Creating Your Own Print File

```openscad
// my_custom_frame.scad
include <frame_module.scad>

// 7×12 frame for my specific needs
grid_frame(cols=7, rows=12);
```

## Technical Details

All frames include:
- Mounting holes in corners with countersinks
- Back cutouts to save filament
- Snap-fit slots for inserts
- No supports needed (print with back side down)
