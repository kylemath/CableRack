// ============================================
// MODULAR CABLE ORGANIZER - BASE INSERT MODULE
// ============================================
// This is the parent module for all insert types
// Include this file and call insert_with_port() with a port shape
// ============================================

include <parameters.scad>

// === BASE INSERT WITH CUSTOM BODY DEPTH ===
module insert_blank_custom(body_depth) {
    union() {
        // Base plate (sits in frame slot)
        rounded_box_rect(insert_width, insert_height, insert_base_depth, 1.5);
        
        // Body (protrudes out front) - custom depth
        translate([0, 0, insert_base_depth])
            rounded_box_rect(insert_body_width, insert_body_height, body_depth, 2);
        
        // Snap tabs on all 4 sides
        snap_tabs_all();
    }
}

// === BASE INSERT (default depth - for backwards compatibility) ===
module insert_blank() {
    insert_blank_custom(insert_body_depth);
}

// === NARROW BASE INSERT WITH CUSTOM BODY DEPTH ===
module insert_blank_narrow_custom(body_depth) {
    union() {
        // Narrow base plate (sits in narrow frame slot)
        rounded_box_rect(insert_width_narrow, insert_height_narrow, insert_base_depth, 1.5);
        
        // Narrow body (protrudes out front) - custom depth
        translate([0, 0, insert_base_depth])
            rounded_box_rect(insert_body_width_narrow, insert_body_height_narrow, body_depth, 2);
        
        // Snap tabs on left/right sides only (narrow width)
        snap_tabs_narrow();
    }
}

// === NARROW BASE INSERT (default depth) ===
module insert_blank_narrow() {
    insert_blank_narrow_custom(insert_body_depth);
}

// === NARROW BLANK WITH LABEL RECESS ===
module insert_blank_label_narrow() {
    // Scale label dimensions for narrow insert
    label_w_narrow = insert_width_narrow - 2;
    label_h_narrow = insert_height_narrow - 4;
    
    difference() {
        insert_blank_narrow();
        translate([0, 0, insert_total_depth - label_depth])
            linear_extrude(label_depth + 0.1)
            square([label_w_narrow, label_h_narrow], center=true);
    }
}

// === INSERT WITH THROUGH-HOLE PORT (custom depth) ===
// Pass body_depth and a 2D shape as children
module insert_with_port_custom(body_depth) {
    total_depth = insert_base_depth + body_depth;
    difference() {
        insert_blank_custom(body_depth);
        
        // Cut port hole ALL THE WAY through (tube shape)
        translate([0, 0, -0.1])
            linear_extrude(total_depth + 0.2)
            offset(r=port_clearance)  // Add clearance to port opening
            children();
    }
}

// === INSERT WITH THROUGH-HOLE PORT (default depth) ===
module insert_with_port() {
    insert_with_port_custom(insert_body_depth) children();
}

// === NARROW INSERT WITH THROUGH-HOLE PORT (custom depth) ===
module insert_with_port_narrow_custom(body_depth) {
    total_depth = insert_base_depth + body_depth;
    difference() {
        insert_blank_narrow_custom(body_depth);
        
        // Cut port hole ALL THE WAY through (tube shape)
        translate([0, 0, -0.1])
            linear_extrude(total_depth + 0.2)
            offset(r=port_clearance)  // Add clearance to port opening
            children();
    }
}

// === NARROW INSERT WITH THROUGH-HOLE PORT (default depth) ===
module insert_with_port_narrow() {
    insert_with_port_narrow_custom(insert_body_depth) children();
}

// === PRE-MADE INSERT MODULES WITH CORRECT DEPTHS ===
module insert_usbc() {
    insert_with_port_custom(usbc_body_depth) port_usbc();
}

module insert_usba() {
    insert_with_port_custom(usba_body_depth) port_usba();
}

module insert_usb_mini() {
    insert_with_port_custom(usb_mini_body_depth) port_usb_mini();
}

module insert_usb_micro() {
    insert_with_port_custom(usb_micro_body_depth) port_usb_micro();
}

module insert_usb_b() {
    insert_with_port_custom(usb_b_body_depth) port_usb_b();
}

module insert_lightning() {
    insert_with_port_custom(lightning_body_depth) port_lightning();
}

module insert_hdmi() {
    insert_with_port_custom(hdmi_body_depth) port_hdmi();
}

module insert_audio_jack() {
    insert_with_port_custom(audio_jack_body_depth) port_audio_jack();
}

// === NARROW PRE-MADE INSERT MODULES ===
module insert_usbc_narrow() {
    insert_with_port_narrow_custom(usbc_body_depth) port_usbc();
}

module insert_usba_narrow() {
    insert_with_port_narrow_custom(usba_body_depth) port_usba();
}

module insert_usb_micro_narrow() {
    insert_with_port_narrow_custom(usb_micro_body_depth) port_usb_micro();
}

module insert_usb_b_narrow() {
    insert_with_port_narrow_custom(usb_b_body_depth) port_usb_b();
}

module insert_lightning_narrow() {
    insert_with_port_narrow_custom(lightning_body_depth) port_lightning();
}

module insert_audio_jack_narrow() {
    insert_with_port_narrow_custom(audio_jack_body_depth) port_audio_jack();
}

// === SNAP TABS (on neck/body - catch on frame cutouts) ===
// Tabs are on the body, positioned to engage with frame wall cutouts
module snap_tabs_all() {
    // Position tabs up on body (clear of base/frame)
    tab_z = insert_base_depth + snap_tab_offset;
    
    // Tabs on all 4 sides of the body
    for (angle = [0, 90, 180, 270]) {
        rotate([0, 0, angle])
            translate([0, insert_body_height/2, tab_z])
            neck_snap_tab();
    }
}

// === NARROW SNAP TABS (front/back - height dimension matches wide inserts) ===
module snap_tabs_narrow() {
    // Position tabs up on body (clear of base/frame)
    tab_z = insert_base_depth + snap_tab_offset;
    
    // Tabs on front and back only (0 and 180 degrees)
    // Height is same as wide inserts, so these will properly engage
    for (angle = [0, 180]) {
        rotate([0, 0, angle])
            translate([0, insert_body_height_narrow/2, tab_z])
            neck_snap_tab();
    }
}

module neck_snap_tab() {
    // Wedge shape (FLIPPED): 
    // - Peak/taper on BOTTOM - slides past back plate when inserting
    // - Flat on TOP - catches and holds
    hull() {
        // Peak of wedge (protruding, at BOTTOM of tab)
        translate([-snap_tab_width/2, snap_tab_protrude, 0])
            cube([snap_tab_width, 0.1, 0.1]);
        // Flat top (at body surface, TOP of tab)
        translate([-snap_tab_width/2, 0, snap_tab_thick])
            cube([snap_tab_width, 0.1, 0.1]);
        // Base of wedge (at body surface, bottom)
        translate([-snap_tab_width/2, 0, 0])
            cube([snap_tab_width, 0.1, 0.1]);
    }
}

module snap_tab_horizontal() {
    hull() {
        translate([0, -snap_tab_protrude/2, 0])
            cube([snap_tab_width, 0.1, snap_tab_thick], center=true);
        translate([0, snap_tab_protrude/2, snap_tab_thick * 0.2])
            cube([snap_tab_width, 0.1, snap_tab_thick * 0.6], center=true);
    }
}

module snap_tab_vertical() {
    hull() {
        translate([-snap_tab_protrude/2, 0, 0])
            cube([0.1, snap_tab_width, snap_tab_thick], center=true);
        translate([snap_tab_protrude/2, 0, snap_tab_thick * 0.2])
            cube([0.1, snap_tab_width, snap_tab_thick * 0.6], center=true);
    }
}

// === UTILITY MODULES ===
module rounded_box_rect(w, d, h, r) {
    translate([0, 0, h/2])
        hull() {
            for (x = [-1, 1], y = [-1, 1])
                translate([x * (w/2 - r), y * (d/2 - r), 0])
                    cylinder(h=h, r=r, center=true);
        }
}

// === PORT SHAPE MODULES (2D) ===
// These define the cutout shapes for each connector type

module port_rounded_rect(w, h, r) {
    // Standard rounded rectangle
    hull() {
        for (x = [-1, 1], y = [-1, 1])
            translate([x * (w/2 - r), y * (h/2 - r)])
                circle(r=r);
    }
}

module port_usbc() {
    port_rounded_rect(usbc_w, usbc_h, usbc_r);
}

module port_usba() {
    port_rounded_rect(usba_w, usba_h, usba_r);
}

module port_usb_mini() {
    port_rounded_rect(usb_mini_w, usb_mini_h, usb_mini_r);
}

module port_usb_micro() {
    port_rounded_rect(usb_micro_w, usb_micro_h, usb_micro_r);
}

module port_usb_b() {
    // USB-B has slightly beveled top corners (more square than previous version)
    hull() {
        // Bottom corners (full width, rounded)
        for (x = [-1, 1])
            translate([x * (usb_b_w/2 - usb_b_r), -(usb_b_h/2 - usb_b_r)])
                circle(r=usb_b_r);
        // Top corners (slightly chamfered - only 0.5mm inward for subtle bevel)
        for (x = [-1, 1])
            translate([x * (usb_b_w/2 - usb_b_r - 0.5), (usb_b_h/2 - usb_b_r)])
                circle(r=usb_b_r);
    }
}

module port_lightning() {
    port_rounded_rect(lightning_w, lightning_h, lightning_r);
}

module port_hdmi() {
    // HDMI is tapered (wider at bottom, narrower at top - correct orientation)
    hull() {
        // Top (narrower)
        for (x = [-1, 1])
            translate([x * (hdmi_w/2 - hdmi_r - 0.8), (hdmi_h/2 - hdmi_r)])
                circle(r=hdmi_r);
        // Bottom (wider)
        for (x = [-1, 1])
            translate([x * (hdmi_w/2 - hdmi_r), -(hdmi_h/2 - hdmi_r)])
                circle(r=hdmi_r);
    }
}

module port_audio_jack() {
    circle(d=audio_jack_dia);
}

module port_label_recess() {
    // Shallow rectangular recess for labels
    square([label_w, label_h], center=true);
}

// === RENDER (for testing this file directly) ===
// insert_blank();
