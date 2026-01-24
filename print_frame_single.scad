// ============================================
// PRINT FILE: Single Slot Frame
// ============================================
// Export this to STL for 3D printing
// Print flat side down (no supports needed)
// ============================================

include <parameters.scad>
include <insert_base.scad>

// Single slot frame module
module print_frame() {
    outer_w = slot_width + (2 * frame_wall);
    outer_h = slot_height + (2 * frame_wall);
    
    difference() {
        // Outer body
        rounded_box_rect(outer_w, outer_h, frame_total_depth, 2);
        
        // Main slot cutout (from back to front)
        translate([0, 0, frame_back + slot_depth/2 + 0.1])
            cube([slot_width, slot_height, slot_depth + 0.2], center=true);
        
        // Back opening (smaller, for insert body to pass through)
        translate([0, 0, -0.1])
            rounded_box_rect(insert_body_width + 2*clearance, 
                            insert_body_height + 2*clearance, 
                            frame_back + 0.2, 1);
        
        // Tab engagement cutouts
        tab_cutouts();
    }
}

// Tab engagement cutouts in frame OUTER WALLS
// These create pockets in the slot walls for snap tabs to engage with
module tab_cutouts() {
    // Cutout dimensions
    tab_cutout_width = snap_tab_width + 1;  // Width along X (parallel to wall)
    tab_cutout_height = snap_tab_thick + 1;  // Height in Z
    tab_cutout_into_wall = (snap_tab_protrude + 1) / 2;  // How deep into wall material (half depth)
    
    // Z position: moved up into the slot (away from back plate)
    // Position about halfway up the slot depth
    cutout_z = frame_back + slot_depth/2;
    
    // Slot wall position (outer edge of slot cavity)
    wall_y = slot_height/2;
    
    // Cutouts ONLY on +Y and -Y walls (the LONG sides - top and bottom)
    // Positioned at the outer wall, extending INTO the frame material
    for (ym = [-1, 1]) {
        translate([0, ym * (wall_y + tab_cutout_into_wall/2 - 0.1), cutout_z])
            cube([tab_cutout_width, tab_cutout_into_wall + 0.2, tab_cutout_height], center=true);
    }
}

// Render for export
print_frame();
