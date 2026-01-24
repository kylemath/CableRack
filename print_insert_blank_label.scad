// ============================================
// PRINT FILE: Blank Label Insert
// ============================================
// Body depth: 12mm (default depth)
// Has recessed area for label
// Print with flat side DOWN (on bed)
// No supports needed
// ============================================

include <parameters.scad>
include <insert_base.scad>

// Blank Label insert - oriented for printing (flat side down)
total_depth = insert_base_depth + insert_body_depth;

module insert_blank_label() {
    difference() {
        insert_blank();
        translate([0, 0, insert_total_depth - label_depth])
            linear_extrude(label_depth + 0.1)
            square([label_w, label_h], center=true);
    }
}

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_blank_label();
