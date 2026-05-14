// ============================================
// FRAME VALIDATION TEST
// ============================================
// Comprehensive test showing:
// 1. Wall thickness validation (2.4mm = 6 layers @ 0.4mm nozzle)
// 2. Insert clearance validation
// 3. Single, 2x2, and 3x3 frame comparison
// ============================================

include <parameters.scad>
include <insert_base.scad>

// === PARAMETRIC FRAME GENERATOR ===
module parametric_frame(cols, rows) {
    local_grid_width = (cols * slot_width) + ((cols - 1) * frame_wall);
    local_grid_height = (rows * slot_height) + ((rows - 1) * frame_wall);
    local_frame_width = local_grid_width + (2 * frame_border);
    local_frame_height = local_grid_height + (2 * frame_border);
    
    difference() {
        // Main frame body
        rounded_box_rect(local_frame_width, local_frame_height, frame_total_depth, 3);
        
        // Slot cutouts
        for (col = [0 : cols-1], row = [0 : rows-1]) {
            x = (col - (cols-1)/2) * (slot_width + frame_wall);
            y = (row - (rows-1)/2) * (slot_height + frame_wall);
            translate([x, y, frame_back + slot_depth/2 + 0.1])
                cube([slot_width, slot_height, slot_depth + 0.2], center=true);
        }
        
        // Back cutouts for insert bodies
        cutout_w = insert_body_width + 2*clearance;
        cutout_h = insert_body_height + 2*clearance;
        for (col = [0 : cols-1], row = [0 : rows-1]) {
            x = (col - (cols-1)/2) * (slot_width + frame_wall);
            y = (row - (rows-1)/2) * (slot_height + frame_wall);
            translate([x, y, -0.1])
                rounded_box_rect(cutout_w, cutout_h, frame_back + 0.2, 1);
        }
        
        // Mounting holes (4 corners)
        if (cols > 1 || rows > 1) {  // Only add mounting holes for multi-slot frames
            hx = local_frame_width/2 - frame_border/2 - 1;
            hy = local_frame_height/2 - frame_border/2 - 1;
            for (xm = [-1, 1], ym = [-1, 1]) {
                translate([xm * hx, ym * hy, -0.1]) {
                    cylinder(d=mount_hole_dia, h=frame_total_depth + 0.2);
                    cylinder(d1=countersink_dia, d2=mount_hole_dia, h=countersink_depth);
                }
            }
        }
    }
}

// === WALL THICKNESS CROSS-SECTION TEST ===
module wall_thickness_test() {
    difference() {
        parametric_frame(2, 1);  // 1x2 frame to show wall
        
        // Cut away half to show cross-section
        translate([0, -50, -1])
            cube([100, 100, 20]);
    }
    
    // Add dimension marker
    color("red")
    translate([0, 5, frame_total_depth + 1])
        linear_extrude(0.4)
        text(str(frame_wall, "mm wall"), 
             size=3, 
             halign="center");
}

// === INSERT FIT TEST ===
// Shows inserts with clearances highlighted
module insert_fit_test() {
    // Frame
    color("gray", 0.7)
    parametric_frame(2, 1);
    
    // Inserts (highlighted to show they fit)
    for (i = [0, 1]) {
        x = (i - 0.5) * (slot_width + frame_wall);
        #translate([x, 0, frame_back + insert_base_depth])
            rotate([180, 0, 0])
            insert_blank();
    }
}

// === FRAME SIZE COMPARISON ===
// Shows 1x1, 2x2, and 3x3 frames side by side
module frame_comparison() {
    spacing = 85;
    
    // 1x1 (single slot)
    translate([-spacing, 0, 0]) {
        parametric_frame(1, 1);
        color("blue")
        translate([0, 0, frame_total_depth + 1])
            linear_extrude(0.4)
            text("1x1", size=4, halign="center");
    }
    
    // 2x2
    translate([0, 0, 0]) {
        parametric_frame(2, 2);
        color("green")
        translate([0, 0, frame_total_depth + 1])
            linear_extrude(0.4)
            text("2x2", size=4, halign="center");
    }
    
    // 3x3
    translate([spacing, 0, 0]) {
        parametric_frame(3, 3);
        color("red")
        translate([0, 0, frame_total_depth + 1])
            linear_extrude(0.4)
            text("3x3", size=4, halign="center");
    }
}

// === RENDER SELECTION ===
// Uncomment the test you want to view:

// Test 1: Wall thickness cross-section
wall_thickness_test();

// Test 2: Insert fit validation
// insert_fit_test();

// Test 3: Frame size comparison
// frame_comparison();

// Test 4: Just render one frame for printing
// parametric_frame(2, 2);  // 2x2
// parametric_frame(3, 3);  // 3x3
