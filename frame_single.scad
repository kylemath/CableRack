// ============================================
// MODULAR CABLE ORGANIZER - SINGLE SLOT FRAME
// ============================================
// Simple frame with internal lip for snap retention
// Print flat side down (no supports needed)
// ============================================

include <parameters.scad>

// --- Main Module ---
module single_slot_frame() {
    outer_w = slot_width + (2 * frame_wall);
    outer_h = slot_height + (2 * frame_wall);
    
    difference() {
        // Outer body
        rounded_box_rect(outer_w, outer_h, frame_total_depth, 2);
        
        // Main slot cutout (from back to front)
        translate([0, 0, frame_back + slot_depth/2 + 0.1])
            cube([slot_width, slot_height, slot_depth + 0.2], center=true);
        
        // Back opening (smaller, for insert body to pass through)
        // Leaves material for snap tabs to catch on
        translate([0, 0, -0.1])
            rounded_box_rect(insert_body_width + 2*clearance, 
                            insert_body_height + 2*clearance, 
                            frame_back + 0.2, 1);
    }
}

// --- Utility: Rounded Box (rectangular) ---
module rounded_box_rect(w, d, h, r) {
    translate([0, 0, h/2])
        hull() {
            for (x = [-1, 1], y = [-1, 1])
                translate([x * (w/2 - r), y * (d/2 - r), 0])
                    cylinder(h=h, r=r, center=true);
        }
}

// --- Render ---
single_slot_frame();
