// ============================================
// PRINT FILE: USB-C Insert
// ============================================
// Body depth: 9mm (matches USB-C male connector)
// Print with port side DOWN (flat on bed)
// No supports needed - through-hole design
// ============================================

include <parameters.scad>
include <insert_base.scad>

// USB-C insert - oriented for printing (port side down)
// Uses usbc_body_depth (9mm) for correct height
total_depth = insert_base_depth + usbc_body_depth;

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_usbc();
