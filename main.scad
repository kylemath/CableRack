// ============================================
// MODULAR CABLE ORGANIZER - MAIN FILE
// ============================================
// Frame with back cutouts + all insert types
// ============================================

include <parameters.scad>
include <insert_base.scad>

// === FRAME MODULE ===
module grid_frame() {
    difference() {
        // Main frame body
        rounded_box_rect(frame_width, frame_height_total, frame_total_depth, 3);
        
        // Cut slot recesses from front
        translate([0, 0, frame_back])
            slot_grid();
        
        // Cut back panel to save filament (leave border and ribs)
        back_cutouts();
        
        // Mounting holes in corners
        mounting_holes();
    }
}

module slot_grid() {
    for (col = [0 : grid_cols-1]) {
        for (row = [0 : grid_rows-1]) {
            x = (col - (grid_cols-1)/2) * (slot_width + frame_wall);
            y = (row - (grid_rows-1)/2) * (slot_height + frame_wall);
            
            translate([x, y, 0])
                slot_recess();
        }
    }
}

module slot_recess() {
    // Simple slot cavity - no wall grooves needed!
    // Tabs are on the neck and catch on back plate
    translate([0, 0, slot_depth/2 + 0.1])
        cube([slot_width, slot_height, slot_depth + 0.2], center=true);
}

module back_cutouts() {
    // Back cutout sized for body/neck to pass through
    // Leaves material around edges for tabs to catch on
    cutout_w = insert_body_width + 2*clearance;
    cutout_h = insert_body_height + 2*clearance;
    
    for (col = [0 : grid_cols-1]) {
        for (row = [0 : grid_rows-1]) {
            x = (col - (grid_cols-1)/2) * (slot_width + frame_wall);
            y = (row - (grid_rows-1)/2) * (slot_height + frame_wall);
            
            translate([x, y, -0.1])
                rounded_box_rect(cutout_w, cutout_h, frame_back + 0.2, 1);
        }
    }
}

module mounting_holes() {
    hole_offset_x = frame_width/2 - frame_border/2;
    hole_offset_y = frame_height_total/2 - frame_border/2;
    
    for (xm = [-1, 1], ym = [-1, 1]) {
        translate([xm * hole_offset_x, ym * hole_offset_y, -0.1]) {
            // Through hole for screw shaft
            cylinder(d=mount_hole_dia, h=frame_total_depth + 0.2);
            // Countersink on back face (mounting surface)
            cylinder(d1=countersink_dia, d2=mount_hole_dia, h=countersink_depth);
        }
    }
}

// === INSERT MODULES (using base) ===
module insert_usbc() {
    insert_with_port() port_usbc();
}

module insert_usba() {
    insert_with_port() port_usba();
}

module insert_usb_mini() {
    insert_with_port() port_usb_mini();
}

module insert_usb_micro() {
    insert_with_port() port_usb_micro();
}

module insert_usb_b() {
    insert_with_port() port_usb_b();
}

module insert_lightning() {
    insert_with_port() port_lightning();
}

module insert_hdmi() {
    insert_with_port() port_hdmi();
}

module insert_audio_jack() {
    insert_with_port() port_audio_jack();
}

module insert_blank_label() {
    difference() {
        insert_blank();
        translate([0, 0, insert_total_depth - label_depth])
            linear_extrude(label_depth + 0.1)
            square([label_w, label_h], center=true);
    }
}

// ============================================
// RENDER OPTIONS
// ============================================
show_frame = true;
show_insert = true;
assembled = false;

// Which insert to show: 
// "usbc", "usba", "usb_mini", "usb_micro", "usb_b", 
// "lightning", "hdmi", "audio_jack", "blank_label", "blank"
insert_type = "usbc";

module selected_insert() {
    if (insert_type == "usbc") insert_usbc();
    else if (insert_type == "usba") insert_usba();
    else if (insert_type == "usb_mini") insert_usb_mini();
    else if (insert_type == "usb_micro") insert_usb_micro();
    else if (insert_type == "usb_b") insert_usb_b();
    else if (insert_type == "lightning") insert_lightning();
    else if (insert_type == "hdmi") insert_hdmi();
    else if (insert_type == "audio_jack") insert_audio_jack();
    else if (insert_type == "blank_label") insert_blank_label();
    else insert_blank();
}

// === RENDER ===
if (assembled) {
    color("DimGray") grid_frame();
    
    // Place insert in one slot
    slot_x = -0.5 * (slot_width + frame_wall);
    slot_y = -0.5 * (slot_height + frame_wall);
    translate([slot_x, slot_y, frame_back])
        color("SteelBlue") selected_insert();
} else {
    if (show_frame)
        translate([-70, 0, 0])
            color("DimGray") grid_frame();
    
    if (show_insert)
        translate([45, 0, 0])
            color("SteelBlue") selected_insert();
}

// === SHOWCASE ALL INSERTS ===
module showcase_all_inserts() {
    spacing = 60;
    
    translate([0*spacing, 0, 0]) { color("SteelBlue") insert_usbc(); }
    translate([1*spacing, 0, 0]) { color("Coral") insert_usba(); }
    translate([2*spacing, 0, 0]) { color("MediumSeaGreen") insert_usb_mini(); }
    
    translate([0*spacing, -35, 0]) { color("Orchid") insert_usb_micro(); }
    translate([1*spacing, -35, 0]) { color("Gold") insert_usb_b(); }
    translate([2*spacing, -35, 0]) { color("Tomato") insert_lightning(); }
    
    translate([0*spacing, -70, 0]) { color("CornflowerBlue") insert_hdmi(); }
    translate([1*spacing, -70, 0]) { color("LightGreen") insert_audio_jack(); }
    translate([2*spacing, -70, 0]) { color("Silver") insert_blank_label(); }
}

// Uncomment to see all 9 inserts:
// showcase_all_inserts();

// === EXPORT (uncomment one) ===
// grid_frame();
// insert_usbc();
// insert_usba();
// insert_usb_mini();
// insert_usb_micro();
// insert_usb_b();
// insert_lightning();
// insert_hdmi();
// insert_audio_jack();
// insert_blank_label();
// insert_blank();
