// ============================================
// PRINT FILE: 2x2 Frame (4 slots)
// ============================================
// Print with back side down (no supports needed)
// ============================================

include <parameters.scad>
include <insert_base.scad>

// === 2x2 FRAME MODULE ===
module grid_frame() {
    difference() {
        rounded_box_rect(frame_width, frame_height_total, frame_total_depth, 3);
        translate([0, 0, frame_back]) slot_grid();
        back_cutouts();
        mounting_holes();
    }
}

module slot_grid() {
    for (col = [0 : grid_cols-1], row = [0 : grid_rows-1]) {
        x = (col - (grid_cols-1)/2) * (slot_width + frame_wall);
        y = (row - (grid_rows-1)/2) * (slot_height + frame_wall);
        translate([x, y, 0]) slot_recess();
    }
}

module slot_recess() {
    translate([0, 0, slot_depth/2 + 0.1])
        cube([slot_width, slot_height, slot_depth + 0.2], center=true);
}

module back_cutouts() {
    cutout_w = insert_body_width + 2*clearance;
    cutout_h = insert_body_height + 2*clearance;
    
    for (col = [0 : grid_cols-1], row = [0 : grid_rows-1]) {
        x = (col - (grid_cols-1)/2) * (slot_width + frame_wall);
        y = (row - (grid_rows-1)/2) * (slot_height + frame_wall);
        translate([x, y, -0.1])
            rounded_box_rect(cutout_w, cutout_h, frame_back + 0.2, 1);
    }
}

module mounting_holes() {
    hx = frame_width/2 - frame_border/2 - 1;
    hy = frame_height_total/2 - frame_border/2 - 1;
    for (xm = [-1, 1], ym = [-1, 1]) {
        translate([xm * hx, ym * hy, -0.1]) {
            // Through hole for screw shaft
            cylinder(d=mount_hole_dia, h=frame_total_depth + 0.2);
            // Countersink on back face (mounting surface)
            cylinder(d1=countersink_dia, d2=mount_hole_dia, h=countersink_depth);
        }
    }
}

// Render
grid_frame();
