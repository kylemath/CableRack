// ============================================
// PRINT FILE: USB-A Insert
// ============================================
// Body depth: 13mm (matches USB-A male connector)
// Print with port side DOWN (flat on bed)
// No supports needed - through-hole design
// ============================================

include <parameters.scad>
include <insert_base.scad>

// USB-A insert - oriented for printing (port side down)
total_depth = insert_base_depth + usba_body_depth;

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_usba();
