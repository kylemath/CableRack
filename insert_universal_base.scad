// ============================================
// UNIVERSAL CONNECTOR SYSTEM - BASE INSERT MODULE
// ============================================
// Extended insert design with:
// - Internal PCB cavity for signal routing
// - 24-pin universal connector interface on rear
// - Compatible with existing frame system
// ============================================

include <insert_base.scad>

// === UNIVERSAL CONNECTOR PARAMETERS ===

// 24-pin connector dimensions (2x12 array, 1.27mm pitch)
uc_pin_pitch = 1.27;
uc_pin_rows = 2;
uc_pin_cols = 12;
uc_connector_width = (uc_pin_cols - 1) * uc_pin_pitch + 3.0;  // ~17mm with housing
uc_connector_height = (uc_pin_rows - 1) * uc_pin_pitch + 2.5; // ~4mm with housing
uc_connector_depth = 4.0;  // Connector mating depth

// PCB cavity dimensions
pcb_thickness = 1.0;
pcb_clearance = 0.3;
pcb_cavity_width = insert_body_width - 2;   // Leave 1mm wall on each side
pcb_cavity_height = insert_body_height - 3; // Leave wall for structural integrity
pcb_cavity_depth = 8.0;  // Depth for PCB + components

// Extended body for universal connector
uc_body_extension = 6.0;  // Extra depth for 24-pin connector housing

// === UNIVERSAL INSERT BASE (WIDE) ===
// Accepts original connector on front, has 24-pin interface on rear
module insert_universal_base_custom(body_depth, original_port_depth) {
    total_depth = insert_base_depth + body_depth + uc_body_extension;
    pcb_start_z = insert_base_depth + original_port_depth;
    
    difference() {
        union() {
            // Base plate (sits in frame slot) - same as original
            rounded_box_rect(insert_width, insert_height, insert_base_depth, 1.5);
            
            // Extended body (protrudes out front)
            translate([0, 0, insert_base_depth])
                rounded_box_rect(insert_body_width, insert_body_height, 
                                body_depth + uc_body_extension, 2);
            
            // Snap tabs
            snap_tabs_all();
        }
        
        // PCB cavity (from behind original connector to near rear)
        translate([0, 0, pcb_start_z])
            pcb_cavity(pcb_cavity_depth);
        
        // 24-pin connector opening on rear face
        translate([0, 0, total_depth - uc_connector_depth - 0.1])
            linear_extrude(uc_connector_depth + 0.2)
            uc_connector_opening();
        
        // Wire routing channels from PCB to 24-pin connector
        translate([0, 0, pcb_start_z + pcb_cavity_depth - 1])
            wire_routing_channels();
    }
}

// === UNIVERSAL INSERT BASE (NARROW) ===
module insert_universal_base_narrow_custom(body_depth, original_port_depth) {
    total_depth = insert_base_depth + body_depth + uc_body_extension;
    pcb_start_z = insert_base_depth + original_port_depth;
    
    // Narrow PCB dimensions
    pcb_cavity_width_narrow = insert_body_width_narrow - 1.5;
    
    difference() {
        union() {
            // Narrow base plate
            rounded_box_rect(insert_width_narrow, insert_height_narrow, 
                            insert_base_depth, 1.5);
            
            // Extended narrow body
            translate([0, 0, insert_base_depth])
                rounded_box_rect(insert_body_width_narrow, insert_body_height_narrow, 
                                body_depth + uc_body_extension, 2);
            
            // Snap tabs (narrow version)
            snap_tabs_narrow();
        }
        
        // Smaller PCB cavity for narrow insert
        translate([0, 0, pcb_start_z])
            pcb_cavity_narrow(pcb_cavity_depth);
        
        // 24-pin connector opening (same size, centered)
        translate([0, 0, total_depth - uc_connector_depth - 0.1])
            linear_extrude(uc_connector_depth + 0.2)
            uc_connector_opening();
    }
}

// === PCB CAVITY MODULE ===
module pcb_cavity(depth) {
    // Main PCB slot
    translate([0, 0, depth/2])
        cube([pcb_cavity_width, pcb_cavity_height, depth], center=true);
    
    // Component clearance on top of PCB
    translate([0, 0, pcb_thickness + depth/2])
        cube([pcb_cavity_width - 2, pcb_cavity_height - 2, depth], center=true);
}

module pcb_cavity_narrow(depth) {
    narrow_pcb_w = insert_body_width_narrow - 1.5;
    narrow_pcb_h = insert_body_height_narrow - 2;
    
    translate([0, 0, depth/2])
        cube([narrow_pcb_w, narrow_pcb_h, depth], center=true);
}

// === 24-PIN CONNECTOR OPENING ===
module uc_connector_opening() {
    // Rectangular opening for 24-pin connector
    // Slightly oversized for tolerance
    offset(r=0.2)
        square([uc_connector_width, uc_connector_height], center=true);
}

// === 24-PIN CONTACT ARRAY (for visualization) ===
module uc_pin_array() {
    // Visual representation of the 24 pins
    for (row = [0:uc_pin_rows-1]) {
        for (col = [0:uc_pin_cols-1]) {
            x = (col - (uc_pin_cols-1)/2) * uc_pin_pitch;
            y = (row - (uc_pin_rows-1)/2) * uc_pin_pitch;
            translate([x, y, 0])
                cylinder(d=0.8, h=3, $fn=12);
        }
    }
}

// === WIRE ROUTING CHANNELS ===
module wire_routing_channels() {
    // Channels for routing wires from PCB to 24-pin connector
    channel_width = 1.5;
    channel_height = 2.0;
    
    // Left side channel
    translate([-pcb_cavity_width/4, 0, channel_height/2])
        cube([channel_width, pcb_cavity_height - 2, channel_height + 4], center=true);
    
    // Right side channel  
    translate([pcb_cavity_width/4, 0, channel_height/2])
        cube([channel_width, pcb_cavity_height - 2, channel_height + 4], center=true);
    
    // Center channel
    translate([0, 0, channel_height/2])
        cube([channel_width, pcb_cavity_height - 2, channel_height + 4], center=true);
}

// === UNIVERSAL USB-C ADAPTER INSERT ===
module insert_universal_usbc() {
    difference() {
        insert_universal_base_custom(usbc_body_depth, usbc_body_depth);
        
        // Original USB-C port opening (front)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + usbc_body_depth + 0.2)
            offset(r=port_clearance)
            port_usbc();
    }
}

// === UNIVERSAL USB-A ADAPTER INSERT ===
module insert_universal_usba() {
    difference() {
        insert_universal_base_custom(usba_body_depth, usba_body_depth);
        
        // Original USB-A port opening (front)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + usba_body_depth + 0.2)
            offset(r=port_clearance)
            port_usba();
    }
    
    // Retention ribs
    rib_z = insert_base_depth + usba_retention_rib_depth;
    for (side = [-1, 1]) {
        translate([side * (usba_w/2 - usba_retention_rib_size), 0, rib_z])
            cube([usba_retention_rib_size * 2, usba_h - 1, 1.5], center=true);
    }
}

// === UNIVERSAL HDMI ADAPTER INSERT ===
module insert_universal_hdmi() {
    difference() {
        insert_universal_base_custom(hdmi_body_depth, hdmi_body_depth);
        
        // Original HDMI port opening (front)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + hdmi_body_depth + 0.2)
            offset(r=port_clearance)
            port_hdmi();
        
        // Extra cavity for active converter IC
        translate([0, 0, insert_base_depth + hdmi_body_depth + 2])
            cube([20, 8, 6], center=true);
    }
}

// === UNIVERSAL DISPLAYPORT ADAPTER INSERT ===
// DisplayPort dimensions (not in original parameters.scad)
dp_w = 16.1;  // DisplayPort width
dp_h = 4.8;   // DisplayPort height
dp_r = 0.5;   // Corner radius
dp_body_depth = 14;

module port_displayport() {
    // DisplayPort is asymmetric - one corner is clipped
    hull() {
        // Top left (clipped corner)
        translate([-(dp_w/2 - dp_r - 1.5), (dp_h/2 - dp_r)])
            circle(r=dp_r);
        // Top right
        translate([(dp_w/2 - dp_r), (dp_h/2 - dp_r)])
            circle(r=dp_r);
        // Bottom corners (full width)
        for (x = [-1, 1])
            translate([x * (dp_w/2 - dp_r), -(dp_h/2 - dp_r)])
                circle(r=dp_r);
    }
}

module insert_universal_displayport() {
    difference() {
        insert_universal_base_custom(dp_body_depth, dp_body_depth);
        
        // DisplayPort opening (front)
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + dp_body_depth + 0.2)
            offset(r=port_clearance)
            port_displayport();
    }
}

// === UNIVERSAL LIGHTNING ADAPTER INSERT (NARROW) ===
module insert_universal_lightning_narrow() {
    difference() {
        insert_universal_base_narrow_custom(lightning_body_depth, lightning_body_depth);
        
        // Lightning port opening
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + lightning_body_depth + 0.2)
            offset(r=port_clearance)
            port_lightning();
    }
}

// === UNIVERSAL AUDIO JACK ADAPTER INSERT (NARROW) ===
module insert_universal_audio_narrow() {
    difference() {
        insert_universal_base_narrow_custom(audio_jack_body_depth, audio_jack_body_depth);
        
        // Audio jack opening
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + audio_jack_body_depth + 0.2)
            offset(r=port_clearance)
            port_audio_jack();
    }
}

// === UNIVERSAL MALE TERMINATOR ===
// The cable-end connector that plugs into universal inserts
module universal_male_terminator() {
    housing_width = 20;
    housing_height = 8;
    housing_depth = 16;
    plug_depth = uc_connector_depth - 0.3;  // Slightly shorter for clearance
    
    difference() {
        union() {
            // Main housing body
            translate([0, 0, housing_depth/2])
                rounded_box_rect(housing_width, housing_height, housing_depth, 2);
            
            // 24-pin male plug extension
            translate([0, 0, housing_depth])
                rounded_box_rect(uc_connector_width - 0.4, uc_connector_height - 0.4, 
                                plug_depth, 0.5);
        }
        
        // Cable entry hole (rear)
        translate([0, 0, -0.1])
            linear_extrude(4)
            circle(d=6);
        
        // Internal wire cavity
        translate([0, 0, 3])
            cube([housing_width - 4, housing_height - 3, housing_depth], center=true);
        
        // Strain relief slots
        for (x = [-1, 1]) {
            translate([x * 4, 0, 2])
                cube([2, housing_height + 1, 3], center=true);
        }
    }
    
    // Pin contacts (visualization)
    color("gold")
    translate([0, 0, housing_depth + plug_depth - 2])
        uc_pin_array();
}

// === PASS-THROUGH INSERT (24-pin to 24-pin) ===
// For extending universal cables
module insert_universal_passthrough() {
    total_depth = insert_base_depth + insert_body_depth + uc_body_extension;
    
    difference() {
        union() {
            // Base plate
            rounded_box_rect(insert_width, insert_height, insert_base_depth, 1.5);
            
            // Extended body
            translate([0, 0, insert_base_depth])
                rounded_box_rect(insert_body_width, insert_body_height, 
                                insert_body_depth + uc_body_extension, 2);
            
            snap_tabs_all();
        }
        
        // Front 24-pin opening
        translate([0, 0, -0.1])
            linear_extrude(insert_base_depth + 3)
            uc_connector_opening();
        
        // Rear 24-pin opening
        translate([0, 0, total_depth - uc_connector_depth - 0.1])
            linear_extrude(uc_connector_depth + 0.2)
            uc_connector_opening();
        
        // Through-channel for direct wiring
        translate([0, 0, insert_base_depth + 2])
            cube([uc_connector_width - 2, uc_connector_height + 2, 
                  insert_body_depth + uc_body_extension], center=true);
    }
}

// === DEMO: CROSS-SECTION VIEW ===
module demo_universal_insert_cutaway() {
    difference() {
        insert_universal_usbc();
        
        // Cut away half for cross-section view
        translate([0, -20, -1])
            cube([40, 40, 40]);
    }
}

// === DEMO: ALL UNIVERSAL INSERTS ===
module demo_universal_all() {
    spacing = 40;
    
    // Row 1: Wide inserts
    translate([0, 0, 0]) insert_universal_usbc();
    translate([spacing, 0, 0]) insert_universal_usba();
    translate([spacing*2, 0, 0]) insert_universal_hdmi();
    translate([spacing*3, 0, 0]) insert_universal_displayport();
    
    // Row 2: Narrow inserts and terminator
    translate([0, -25, 0]) insert_universal_lightning_narrow();
    translate([spacing/2, -25, 0]) insert_universal_audio_narrow();
    translate([spacing*1.5, -25, 0]) insert_universal_passthrough();
    translate([spacing*2.5, -25, 0]) universal_male_terminator();
}

// === RENDER OPTIONS ===
// Uncomment one to render:

// Single USB-C universal adapter (default)
insert_universal_usbc();

// Cross-section view
// demo_universal_insert_cutaway();

// All universal inserts
// demo_universal_all();

// Male terminator only
// universal_male_terminator();

// Pass-through insert
// insert_universal_passthrough();
