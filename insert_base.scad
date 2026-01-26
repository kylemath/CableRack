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

// === AC POWER PLUG INSERT (2-prong, no ground) ===
// Uses standard wide insert, with asymmetric holes for polarity
// Centered prongs for 2-prong power plugs only
module insert_power_plug() {
    difference() {
        insert_blank_custom(power_body_depth);
        
        // Hot prong (narrower, on left looking at front)
        translate([-power_prong_spacing/2, 0, -0.1])
            linear_extrude(insert_base_depth + power_body_depth + 0.2)
            offset(r=port_clearance)
            square([power_hot_w, power_hot_h], center=true);
        
        // Neutral prong (wider, on right looking at front)
        translate([power_prong_spacing/2, 0, -0.1])
            linear_extrude(insert_base_depth + power_body_depth + 0.2)
            offset(r=port_clearance)
            square([power_neutral_w, power_neutral_h], center=true);
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
    // USB-C without retention ribs (per user request)
    insert_with_port_custom(usbc_body_depth) port_usbc();
}

module insert_usba() {
    difference() {
        insert_blank_custom(usba_body_depth);
        
        // Main USB-A port hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + usba_body_depth + 0.2)
            offset(r=port_clearance)
            port_usba();
    }
    
    // Add retention ribs on left and right sides (inside the port)
    rib_z = insert_base_depth + usba_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (usba_w/2 - usba_retention_rib_size), 0, rib_z])
            cube([usba_retention_rib_size * 2, usba_h - 1, 1.5], center=true);
    }
}

module insert_usb_mini() {
    difference() {
        insert_blank_custom(usb_mini_body_depth);
        
        // Main USB Mini port hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + usb_mini_body_depth + 0.2)
            offset(r=port_clearance)
            port_usb_mini();
    }
    
    // Add retention ribs on left and right sides
    rib_z = insert_base_depth + usb_mini_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (usb_mini_w/2 - usb_mini_retention_rib_size), 0, rib_z])
            cube([usb_mini_retention_rib_size * 2, usb_mini_h - 0.6, 1.0], center=true);
    }
}

module insert_usb_micro() {
    difference() {
        insert_blank_custom(usb_micro_body_depth);
        
        // Main USB Micro-B port hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + usb_micro_body_depth + 0.2)
            offset(r=port_clearance)
            port_usb_micro();
    }
    
    // Add retention ribs on left and right sides (inside the port)
    rib_z = insert_base_depth + usb_micro_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (usb_micro_w/2 - usb_micro_retention_rib_size), 0, rib_z])
            cube([usb_micro_retention_rib_size * 2, usb_micro_h - 0.4, 1.0], center=true);
    }
}

module insert_usb_b() {
    difference() {
        insert_blank_custom(usb_b_body_depth);
        
        // Main USB-B port hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + usb_b_body_depth + 0.2)
            offset(r=port_clearance)
            port_usb_b();
    }
    
    // Add retention ribs on left and right sides
    rib_z = insert_base_depth + usb_b_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (usb_b_w/2 - usb_b_retention_rib_size), 0, rib_z])
            cube([usb_b_retention_rib_size * 2, usb_b_h - 1.5, 1.5], center=true);
    }
}

module insert_lightning() {
    difference() {
        insert_blank_custom(lightning_body_depth);
        
        // Main Lightning port hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + lightning_body_depth + 0.2)
            offset(r=port_clearance)
            port_lightning();
    }
    
    // Add retention ribs on left and right sides (Lightning has detents on sides)
    rib_z = insert_base_depth + lightning_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (lightning_w/2 - lightning_retention_rib_size), 0, rib_z])
            cube([lightning_retention_rib_size * 2, lightning_h - 0.4, 0.8], center=true);
    }
}

module insert_hdmi() {
    difference() {
        insert_blank_custom(hdmi_body_depth);
        
        // Main HDMI port hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + hdmi_body_depth + 0.2)
            offset(r=port_clearance)
            port_hdmi();
    }
    
    // Add retention ribs on left and right sides
    rib_z = insert_base_depth + hdmi_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (hdmi_w/2 - hdmi_retention_rib_size - 1), 0, rib_z])
            cube([hdmi_retention_rib_size * 2, hdmi_h - 0.8, 1.0], center=true);
    }
}

module insert_audio_jack() {
    difference() {
        insert_blank_custom(audio_jack_body_depth);
        
        // Main audio jack hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + audio_jack_body_depth + 0.2)
            offset(r=port_clearance)
            port_audio_jack();
        
        // Inner ribs for TRS/TRRS rings (2 and 3 channel jacks)
        // Ring 1 groove (for 2-channel TRS)
        translate([0, 0, insert_base_depth + audio_jack_ring1])
            cylinder(d=audio_jack_dia + 1.0, h=0.8, center=true);
        
        // Ring 2 groove (for 3-channel TRRS)
        translate([0, 0, insert_base_depth + audio_jack_ring2])
            cylinder(d=audio_jack_dia + 1.0, h=0.8, center=true);
    }
}

// === NARROW PRE-MADE INSERT MODULES ===
module insert_usbc_narrow() {
    // USB-C without retention ribs (per user request)
    insert_with_port_narrow_custom(usbc_body_depth) port_usbc();
}

module insert_usba_narrow() {
    difference() {
        insert_blank_narrow_custom(usba_body_depth);
        
        // Main USB-A port hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + usba_body_depth + 0.2)
            offset(r=port_clearance)
            port_usba();
    }
    
    // Add retention ribs on left and right sides (inside the port)
    rib_z = insert_base_depth + usba_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (usba_w/2 - usba_retention_rib_size), 0, rib_z])
            cube([usba_retention_rib_size * 2, usba_h - 1, 1.5], center=true);
    }
}

module insert_usb_micro_narrow() {
    difference() {
        insert_blank_narrow_custom(usb_micro_body_depth);
        
        // Main USB Micro-B port hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + usb_micro_body_depth + 0.2)
            offset(r=port_clearance)
            port_usb_micro();
    }
    
    // Add retention ribs on left and right sides (inside the port)
    rib_z = insert_base_depth + usb_micro_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (usb_micro_w/2 - usb_micro_retention_rib_size), 0, rib_z])
            cube([usb_micro_retention_rib_size * 2, usb_micro_h - 0.4, 1.0], center=true);
    }
}

module insert_usb_b_narrow() {
    difference() {
        insert_blank_narrow_custom(usb_b_body_depth);
        
        // Main USB-B port hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + usb_b_body_depth + 0.2)
            offset(r=port_clearance)
            port_usb_b();
    }
    
    // Add retention ribs on left and right sides
    rib_z = insert_base_depth + usb_b_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (usb_b_w/2 - usb_b_retention_rib_size), 0, rib_z])
            cube([usb_b_retention_rib_size * 2, usb_b_h - 1.5, 1.5], center=true);
    }
}

module insert_lightning_narrow() {
    difference() {
        insert_blank_narrow_custom(lightning_body_depth);
        
        // Main Lightning port hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + lightning_body_depth + 0.2)
            offset(r=port_clearance)
            port_lightning();
    }
    
    // Add retention ribs on left and right sides (Lightning has detents on sides)
    rib_z = insert_base_depth + lightning_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (lightning_w/2 - lightning_retention_rib_size), 0, rib_z])
            cube([lightning_retention_rib_size * 2, lightning_h - 0.4, 0.8], center=true);
    }
}

module insert_audio_jack_narrow() {
    difference() {
        insert_blank_narrow_custom(audio_jack_body_depth);
        
        // Main audio jack hole (all the way through)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + audio_jack_body_depth + 0.2)
            offset(r=port_clearance)
            port_audio_jack();
        
        // Inner ribs for TRS/TRRS rings (2 and 3 channel jacks)
        // Ring 1 groove (for 2-channel TRS)
        translate([0, 0, insert_base_depth + audio_jack_ring1])
            cylinder(d=audio_jack_dia + 1.0, h=0.8, center=true);
        
        // Ring 2 groove (for 3-channel TRRS)
        translate([0, 0, insert_base_depth + audio_jack_ring2])
            cylinder(d=audio_jack_dia + 1.0, h=0.8, center=true);
    }
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
    // USB Micro-B has a trapezoid shape with beveled bottom corners
    // This is different from Micro-A which is rectangular
    hull() {
        // Top corners (full width)
        for (x = [-1, 1])
            translate([x * (usb_micro_w/2 - usb_micro_r), (usb_micro_h/2 - usb_micro_r)])
                circle(r=usb_micro_r);
        // Bottom corners (slightly beveled inward for Micro-B shape)
        for (x = [-1, 1])
            translate([x * (usb_micro_w/2 - usb_micro_r - 0.5), -(usb_micro_h/2 - usb_micro_r)])
                circle(r=usb_micro_r);
    }
}

module port_usb_b() {
    // USB-B has trapezoid shape - wider at bottom, narrower at top
    hull() {
        // Bottom corners (full width, rounded)
        for (x = [-1, 1])
            translate([x * (usb_b_w/2 - usb_b_r), -(usb_b_h/2 - usb_b_r)])
                circle(r=usb_b_r);
        // Top corners (narrower - creates proper trapezoid shape)
        for (x = [-1, 1])
            translate([x * (usb_b_w/2 - usb_b_r - usb_b_top_inset), (usb_b_h/2 - usb_b_r)])
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
    // Main hole
    circle(d=audio_jack_dia);
}

module port_label_recess() {
    // Shallow rectangular recess for labels
    square([label_w, label_h], center=true);
}

// === RENDER (for testing this file directly) ===
// insert_blank();
