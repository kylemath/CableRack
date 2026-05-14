// ============================================
// PARAMETERIZED FRAME MODULE
// ============================================
// Call grid_frame(cols, rows) to generate any size frame
// ============================================

include <parameters.scad>

// === PARAMETERIZED FRAME FUNCTION ===
module grid_frame(cols=2, rows=2) {
    // Calculate dimensions based on parameters
    local_grid_width = (cols * slot_width) + ((cols - 1) * frame_wall);
    local_grid_height = (rows * slot_height) + ((rows - 1) * frame_wall);
    local_frame_width = local_grid_width + (2 * frame_border);
    local_frame_height = local_grid_height + (2 * frame_border);
    
    difference() {
        rounded_box_rect(local_frame_width, local_frame_height, frame_total_depth, 3);
        translate([0, 0, frame_back]) slot_grid(cols, rows);
        back_cutouts(cols, rows);
        mounting_holes(local_frame_width, local_frame_height);
    }
}

module slot_grid(cols, rows) {
    for (col = [0 : cols-1], row = [0 : rows-1]) {
        x = (col - (cols-1)/2) * (slot_width + frame_wall);
        y = (row - (rows-1)/2) * (slot_height + frame_wall);
        translate([x, y, 0]) slot_recess();
    }
}

module slot_recess() {
    translate([0, 0, slot_depth/2 + 0.1])
        cube([slot_width, slot_height, slot_depth + 0.2], center=true);
}

module back_cutouts(cols, rows) {
    cutout_w = insert_body_width + 2*clearance;
    cutout_h = insert_body_height + 2*clearance;
    
    for (col = [0 : cols-1], row = [0 : rows-1]) {
        x = (col - (cols-1)/2) * (slot_width + frame_wall);
        y = (row - (rows-1)/2) * (slot_height + frame_wall);
        translate([x, y, -0.1])
            rounded_box_rect(cutout_w, cutout_h, frame_back + 0.2, 1);
    }
}

module mounting_holes(fw, fh) {
    hx = fw/2 - frame_border/2;
    hy = fh/2 - frame_border/2;
    for (xm = [-1, 1], ym = [-1, 1]) {
        translate([xm * hx, ym * hy, -0.1]) {
            // Through hole for screw shaft
            cylinder(d=mount_hole_dia, h=frame_total_depth + 0.2);
            // Countersink on back face (mounting surface)
            cylinder(d1=countersink_dia, d2=mount_hole_dia, h=countersink_depth);
        }
    }
}

// === HELPER MODULE FOR ROUNDED BOX (if not in parameters.scad) ===
module rounded_box_rect(w, h, d, r) {
    hull() {
        for (x = [-(w/2-r), (w/2-r)])
            for (y = [-(h/2-r), (h/2-r)])
                translate([x, y, 0])
                    cylinder(r=r, h=d, $fn=24);
    }
}
