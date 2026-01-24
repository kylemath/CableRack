// ============================================
// MODULAR CABLE ORGANIZER - BLANK INSERT
// ============================================
// Blank insert with snap bumps for frame retention
// No connector hole - use as template or test piece
// ============================================

include <parameters.scad>

// --- Main Module ---
module insert_blank() {
    difference() {
        union() {
            // Base (fits in frame slot)
            rounded_box(insert_base, insert_base, insert_base_height, 1.5);
            
            // Body (raised portion above frame)
            translate([0, 0, insert_base_height])
                rounded_box(insert_body_size, insert_body_size, insert_body_height, 2);
            
            // Snap bumps on all 4 sides
            snap_bumps();
        }
        
        // Hollow out the body (from bottom, leave solid top platform)
        cavity_size = insert_body_size - (2 * wall);
        cavity_height = insert_body_height - insert_top_thick;
        translate([0, 0, insert_base_height - 0.1])
            cube([cavity_size, cavity_size, cavity_height + 0.1], center=true);
    }
}

// --- Snap Bumps ---
module snap_bumps() {
    bump_z = insert_base_height - snap_bump_thickness - 0.5;
    
    for (rot = [0, 90, 180, 270]) {
        rotate([0, 0, rot])
            translate([0, insert_base/2, bump_z])
            snap_bump();
    }
}

module snap_bump() {
    // Triangular bump: ramp bottom for insertion, flat top to catch
    hull() {
        translate([-snap_bump_width/2, 0, 0])
            cube([snap_bump_width, 0.1, snap_bump_thickness]);
        translate([-snap_bump_width/2, snap_bump_height * 0.7, snap_bump_thickness * 0.3])
            cube([snap_bump_width, 0.1, snap_bump_thickness * 0.4]);
    }
}

// --- Utility: Rounded Box ---
module rounded_box(w, d, h, r) {
    translate([0, 0, h/2])
        hull() {
            for (x = [-1, 1], y = [-1, 1]) {
                translate([x * (w/2 - r), y * (d/2 - r), 0])
                    cylinder(h=h, r=r, center=true);
            }
        }
}

// --- Render ---
insert_blank();
