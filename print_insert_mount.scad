// ============================================
// PRINT FILE: Mounting Insert (WIDE)
// ============================================
// Blank front (cable side), keyhole slots on back
// Picture-hanger style mounting for wall/table screws
// Two keyholes for stable, level mounting
// Print with body DOWN (keyholes face UP for clean print)
// No supports needed
// ============================================

include <insert_base.scad>

// Mounting insert - oriented for printing
// Body faces down, base plate with keyholes faces up
total_depth = insert_base_depth + insert_body_depth;

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_mount();
