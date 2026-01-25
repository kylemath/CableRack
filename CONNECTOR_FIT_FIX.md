# Connector Opening Size Fix

## Issue
Lightning and Micro USB inserts had openings that were too small for the actual connectors.

## Root Cause
The dimensions in `parameters.scad` were incorrect based on actual connector specifications:

### Micro USB (USB Micro-B)
- **Old dimensions**: 6.9mm × 1.8mm
- **New dimensions**: 8.0mm × 2.8mm
- **Source**: Official USB-IF specification (Micro-USB Spec Rev 1.01)

### Lightning
- **Old dimensions**: 6.7mm × 1.5mm  
- **New dimensions**: 7.6mm × 1.5mm
- **Source**: Measured from actual Apple Lightning connectors

## Changes Made

### 1. Updated `parameters.scad`
- Line 70-74: Updated Micro USB dimensions from 6.9×1.8mm to 8.0×2.8mm
- Line 82-86: Updated Lightning dimensions from 6.7×1.5mm to 7.6×1.5mm

### 2. Created Test Print File
- **File**: `print_test_all_connectors.scad`
- **Contents**: All 7 connector types (excluding USB-C which already works)
  - Row 1: USB-A, USB Mini, USB Micro, USB-B
  - Row 2: Lightning, HDMI, 3.5mm Audio Jack

## USB-C Reference (Confirmed Working)
- **Dimensions**: 8.4mm × 2.6mm
- **Port clearance**: 0.1mm (applied to all connectors)
- This clearance provides a tight fit that works well

## Next Steps

1. **Generate STL**: Open `print_test_all_connectors.scad` in OpenSCAD and export to STL:
   ```
   File → Export → Export as STL
   Save to: print/print_test_all_connectors.stl
   ```

2. **Test Print**: Print all 7 inserts and test fit with actual cables

3. **Verify Fit**: Each connector should now have proper clearance:
   - Should insert smoothly without force
   - Should have minimal play/wiggle
   - Similar fit quality to USB-C

## Other Connector Dimensions (for reference)
All dimensions are from official specifications or measured from actual connectors:

- **USB-A**: 14.0 × 6.5mm (contact opening ~13.1 × 5.5mm spec + clearance)
- **USB Mini**: 6.9 × 3.0mm
- **USB-B**: 8.0 × 7.5mm (with beveled top)
- **HDMI**: 14.0 × 4.5mm (tapered shape)
- **3.5mm Audio**: 6.0mm diameter

## Port Clearance Philosophy
- All ports use `port_clearance = 0.1mm` (defined in parameters.scad line 11)
- This clearance is added via `offset(r=port_clearance)` in insert_base.scad
- Provides tight fit while allowing smooth insertion
- Tested and confirmed good with USB-C
