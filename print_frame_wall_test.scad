// ============================================
// FRAME WALL THICKNESS TEST
// ============================================
// This file demonstrates the wall thickness between slots
// and validates clearances for inserts
// ============================================

include <parameters.scad>
include <insert_base.scad>

// === TEST LAYOUT ===
// Shows 2 adjacent slots with wall between them to verify thickness
module wall_test() {
    difference() {
        union() {
            // Create a small frame section with 2 slots side-by-side (1x2 grid)
            local_grid_width = (2 * slot_width) + frame_wall;
            local_frame_width = local_grid_width + (2 * frame_border);
            local_frame_height = slot_height + (2 * frame_border);
            
            rounded_box_rect(local_frame_width, local_frame_height, frame_total_depth, 3);
        }
        
        // Cut slots
        for (i = [0, 1]) {
            x = (i - 0.5) * (slot_width + frame_wall);
            translate([x, 0, frame_back + slot_depth/2 + 0.1])
                cube([slot_width, slot_height, slot_depth + 0.2], center=true);
        }
        
        // Back cutouts
        cutout_w = insert_body_width + 2*clearance;
        cutout_h = insert_body_height + 2*clearance;
        for (i = [0, 1]) {
            x = (i - 0.5) * (slot_width + frame_wall);
            translate([x, 0, -0.1])
                rounded_box_rect(cutout_w, cutout_h, frame_back + 0.2, 1);
        }
    }
}

// === TEST WITH INSERTS ===
// Shows the frame with inserts positioned to verify clearances
module test_with_inserts() {
    // Frame section
    wall_test();
    
    // Show two inserts in position (semi-transparent to see clearances)
    #for (i = [0, 1]) {
        x = (i - 0.5) * (slot_width + frame_wall);
        translate([x, 0, 0]) {
            insert_blank();
        }
    }
}

// === MEASUREMENT HELPER ===
// Shows dimensional callouts for verification
module measurement_helper() {
    wall_test();
    
    // Add a text label showing wall thickness
    color("red")
    translate([0, 0, frame_total_depth])
        linear_extrude(0.5)
        text(str("Wall: ", frame_wall, "mm"), 
             size=3, 
             halign="center", 
             valign="center");
}

// === RENDER OPTIONS ===
// Uncomment the one you want to see:

wall_test();              // Basic wall thickness test
// test_with_inserts();     // Test with inserts visible
// measurement_helper();    // Test with dimension label
