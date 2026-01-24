// ============================================
// BLANK / LABEL PLATE INSERT
// Shallow recess for adhesive label
// ============================================

include <insert_base.scad>

module insert_blank_label() {
    difference() {
        insert_blank();
        
        // Shallow recess on top for label
        translate([0, 0, insert_total_depth - label_depth])
            linear_extrude(label_depth + 0.1)
            square([label_w, label_h], center=true);
    }
}

// Render
insert_blank_label();
