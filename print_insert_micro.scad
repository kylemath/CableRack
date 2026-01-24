// ============================================
// PRINT FILE: Micro USB Insert
// ============================================
// Body depth: 7mm (matches Micro USB male connector)
// Print with port side DOWN (flat on bed)
// No supports needed - through-hole design
// ============================================

include <parameters.scad>
include <insert_base.scad>

// Micro USB insert - oriented for printing (port side down)
// Uses usb_micro_body_depth (7mm) for correct height
total_depth = insert_base_depth + usb_micro_body_depth;

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_usb_micro();
