// ============================================
// MODULAR CABLE ORGANIZER - DEMO SHOWCASE
// ============================================
// Shows frame with 4 inserts engaged + all 9 insert types
// Open in OpenSCAD and press F5 to preview
// ============================================

// === DEMO OPTIONS ===
show_cutaway = false;  // Set to true to show cutaway view of insert fitting

include <parameters.scad>
include <insert_base.scad>

// === INSERT MODULES ===
// Note: insert_usbc(), insert_usba(), etc. are now defined in insert_base.scad
// with correct body depths for each connector type

// Blank/Label insert (uses default depth)
module insert_blank_label() {
    difference() {
        insert_blank();
        translate([0, 0, insert_total_depth - label_depth])
            linear_extrude(label_depth + 0.1)
            square([label_w, label_h], center=true);
    }
}

// Helper function to get total depth for each type
function get_total_depth(body_depth) = insert_base_depth + body_depth;

// === FRAME MODULE ===
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
    // Simple slot cavity - no wall grooves needed!
    // Tabs are on the neck and catch on back plate
    translate([0, 0, slot_depth/2 + 0.1])
        cube([slot_width, slot_height, slot_depth + 0.2], center=true);
}

module back_cutouts() {
    // Back cutout sized for body to pass through
    cutout_w = insert_body_width + 2*clearance;  // Body fits through
    cutout_h = insert_body_height + 2*clearance;
    
    for (col = [0 : grid_cols-1], row = [0 : grid_rows-1]) {
        x = (col - (grid_cols-1)/2) * (slot_width + frame_wall);
        y = (row - (grid_rows-1)/2) * (slot_height + frame_wall);
        translate([x, y, -0.1])
            rounded_box_rect(cutout_w, cutout_h, frame_back + 0.2, 1);
    }
}


module mounting_holes() {
    hx = frame_width/2 - frame_border/2-1;
    hy = frame_height_total/2 - frame_border/2-1;
    for (xm = [-1, 1], ym = [-1, 1]) {
        translate([xm * hx, ym * hy, -0.1]) {
            // Through hole for screw shaft
            cylinder(d=mount_hole_dia, h=frame_total_depth + 0.2);
            // Countersink on back face (mounting surface)
            cylinder(d1=countersink_dia, d2=mount_hole_dia, h=countersink_depth);
        }
    }
}

// ============================================
// DEMO LAYOUT
// ============================================

// === ASSEMBLED FRAME (with 4 inserts engaged) ===
// Inserts are flipped 180° - narrow neck goes through back, wide base visible from front
translate([-55, 0, 0]) {
    difference() {
        union() {
            // Frame
            color("DimGray", 0.85) grid_frame();
            
            // 4 different inserts in the 4 slots (flipped upside down)
            // Top-left: USB-C (9mm body)
            translate([-(slot_width + frame_wall)/2, (slot_height + frame_wall)/2, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("SteelBlue") insert_usbc();
            
            // Top-right: USB-A (13mm body)
            translate([(slot_width + frame_wall)/2, (slot_height + frame_wall)/2, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("Coral") insert_usba();
            
            // Bottom-left: HDMI (16mm body)
            translate([-(slot_width + frame_wall)/2, -(slot_height + frame_wall)/2, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("MediumSeaGreen") insert_hdmi();
            
            // // Bottom-right: Micro USB (7mm body)
            // translate([(slot_width + frame_wall)/2, -(slot_height + frame_wall)/2, frame_back + insert_base_depth])
            //     rotate([180, 0, 0])
            //     color("Orchid") insert_usb_micro();
        }
        
        // OPTIONAL CUTAWAY: Cut corner to show cross-section (controlled by show_cutaway flag)
        if (show_cutaway) {
            translate([-(slot_width + frame_wall)/2 - 40, -(slot_height + frame_wall)/2 - 32, -30])
                cube([40, 30, 40]);
        }
    }
}

// === ALL 9 INSERT TYPES (3x3 grid) - showing relative heights ===
// Each insert has correct body depth for its connector type
// All sit on z=0 so you can see the height differences
sx = 50;   // Start X
sp = 40;   // Spacing
spy = 22;  // Y spacing

// Calculate total depths for each type
usbc_total = get_total_depth(usbc_body_depth);           // 12.5mm
usba_total = get_total_depth(usba_body_depth);           // 16.5mm
usb_mini_total = get_total_depth(usb_mini_body_depth);   // 12.5mm
usb_micro_total = get_total_depth(usb_micro_body_depth); // 10.5mm
usb_b_total = get_total_depth(usb_b_body_depth);         // 17.5mm
lightning_total = get_total_depth(lightning_body_depth); // 11.5mm
hdmi_total = get_total_depth(hdmi_body_depth);           // 19.5mm
audio_jack_total = get_total_depth(audio_jack_body_depth); // 17.5mm


// Row 1: USB-C (9mm), USB-A (13mm), USB Mini (9mm)
translate([sx + 0*sp, spy, usbc_total]) rotate([180, 0, 0]) color("SteelBlue") insert_usbc();
translate([sx + 1*sp, spy, usba_total]) rotate([180, 0, 0]) color("Coral") insert_usba();
translate([sx + 2*sp, spy, usb_mini_total]) rotate([180, 0, 0]) color("MediumSeaGreen") insert_usb_mini();

// Row 2: USB Micro (7mm), USB-B (14mm), Lightning (8mm)
translate([sx + 0*sp, 0, usb_micro_total]) rotate([180, 0, 0]) color("Orchid") insert_usb_micro();
translate([sx + 1*sp, 0, usb_b_total]) rotate([180, 0, 0]) color("Goldenrod") insert_usb_b();
translate([sx + 2*sp, 0, lightning_total]) rotate([180, 0, 0]) color("Tomato") insert_lightning();

// Row 3: HDMI (16mm), 3.5mm Jack (14mm), Blank/Label (default 12mm)
translate([sx + 0*sp, -spy, hdmi_total]) rotate([180, 0, 0]) color("CornflowerBlue") insert_hdmi();
translate([sx + 1*sp, -spy, audio_jack_total]) rotate([180, 0, 0]) color("LimeGreen") insert_audio_jack();
translate([sx + 2*sp, -spy, insert_total_depth]) rotate([180, 0, 0]) color("Silver") insert_blank_label();

// ============================================
// LEGEND (with body depths)
// ============================================
// Row 1: USB-C (9mm) | USB-A (13mm) | USB Mini (9mm)
// Row 2: USB Micro (7mm) | USB-B (14mm) | Lightning (8mm)
// Row 3: HDMI (16mm) | Audio Jack (14mm) | Blank/Label (12mm)

