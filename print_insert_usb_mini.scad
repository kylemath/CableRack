// ============================================
// PRINT FILE: USB Mini Insert
// ============================================
// Body depth: 9mm (matches USB Mini male connector)
// Print with port side DOWN (flat on bed)
// No supports needed - through-hole design
// ============================================

include <parameters.scad>
include <insert_base.scad>

// USB Mini insert - oriented for printing (port side down)
total_depth = insert_base_depth + usb_mini_body_depth;

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_usb_mini();
