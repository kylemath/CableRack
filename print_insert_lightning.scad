// ============================================
// PRINT FILE: Lightning Insert
// ============================================
// Body depth: 8mm (matches Lightning male connector)
// Print with port side DOWN (flat on bed)
// No supports needed - through-hole design
// ============================================

include <parameters.scad>
include <insert_base.scad>

// Lightning insert - oriented for printing (port side down)
total_depth = insert_base_depth + lightning_body_depth;

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_lightning();
