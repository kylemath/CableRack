// ============================================
// PRINT FILE: Test Set
// ============================================
// Contains:
// - 1x 2x2 Frame (4 slots)
// - 1x USB-C Insert
// - 1x Micro USB Insert
// 
// All pieces arranged for single print
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
        translate([x, y, 0]) tab_cutouts();
    }
}

module tab_cutouts() {
    tab_cutout_width = snap_tab_width + 1;
    tab_cutout_height = snap_tab_thick + 1;
    tab_cutout_into_wall = (snap_tab_protrude + 1) / 2;  // Half depth
    
    cutout_z = frame_back + slot_depth/2;
    wall_y = slot_height/2;
    
    for (ym = [-1, 1]) {
        translate([0, ym * (wall_y + tab_cutout_into_wall/2 - 0.1), cutout_z])
            cube([tab_cutout_width, tab_cutout_into_wall + 0.2, tab_cutout_height], center=true);
    }
}

module mounting_holes() {
    hx = frame_width/2 - frame_border/2;
    hy = frame_height_total/2 - frame_border/2;
    for (xm = [-1, 1], ym = [-1, 1])
        translate([xm * hx, ym * hy, -0.1])
            cylinder(d=mount_hole_dia, h=frame_total_depth + 0.2);
}

// === INSERT MODULES ===
module insert_usbc() {
    insert_with_port() port_usbc();
}

module insert_usb_micro() {
    insert_with_port() port_usb_micro();
}

// ============================================
// PRINT LAYOUT
// ============================================
// Arrange all pieces on the print bed

// Frame (centered, print with back side down)
translate([0, 0, 0])
    grid_frame();

// USB-C Insert (to the right, print with port side down)
translate([frame_width/2 + 25, 10, 0])
    rotate([180, 0, 0])
    translate([0, 0, -insert_total_depth])
    insert_usbc();

// Micro USB Insert (to the right, below USB-C)
translate([frame_width/2 + 25, -10, 0])
    rotate([180, 0, 0])
    translate([0, 0, -insert_total_depth])
    insert_usb_micro();
