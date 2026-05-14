// ============================================
// PRINT FILE: Mounting Insert (NARROW)
// ============================================
// Blank front (cable side), keyhole slot on back
// Picture-hanger style mounting for wall/table screws
// Single centered keyhole for narrow slot
// Print with body DOWN (keyhole faces UP for clean print)
// No supports needed
// ============================================

include <insert_base.scad>

// Narrow mounting insert - oriented for printing
// Body faces down, base plate with keyhole faces up
total_depth = insert_base_depth + insert_body_depth;

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_mount_narrow();
