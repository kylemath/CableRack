// ============================================
// PRINT FILE: HDMI Insert
// ============================================
// Body depth: 16mm (matches HDMI male connector)
// Print with port side DOWN (flat on bed)
// No supports needed - through-hole design
// ============================================

include <parameters.scad>
include <insert_base.scad>

// HDMI insert - oriented for printing (port side down)
total_depth = insert_base_depth + hdmi_body_depth;

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_hdmi();
