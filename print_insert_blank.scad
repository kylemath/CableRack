// ============================================
// PRINT FILE: Blank Insert
// ============================================
// Body depth: 12mm (default depth)
// Print with flat side DOWN (on bed)
// No supports needed
// ============================================

include <parameters.scad>
include <insert_base.scad>

// Blank insert - oriented for printing (flat side down)
total_depth = insert_base_depth + insert_body_depth;

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_blank();
