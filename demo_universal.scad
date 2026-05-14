// ============================================
// UNIVERSAL CONNECTOR SYSTEM - DEMO VISUALIZATION
// ============================================
// Shows all components of the universal connector system:
// - Device adapter inserts (various connector types)
// - Universal male terminators
// - Cross-section views
// ============================================

include <insert_universal_base.scad>

// === VISUALIZATION OPTIONS ===
show_cross_section = false;  // Set true to see internal structure
show_assembly = true;        // Set true to see insert + terminator mated
show_all_types = false;      // Set true to see all adapter types

// === COLORS ===
color_insert = "SlateGray";
color_terminator = "DimGray";
color_pcb = "DarkGreen";
color_contacts = "Gold";

// === ASSEMBLY VIEW: INSERT + MATED TERMINATOR ===
module assembly_view() {
    // Frame slot visualization (ghost)
    color("LightBlue", 0.3)
    translate([0, 0, -slot_depth])
        cube([slot_width, slot_height, slot_depth], center=true);
    
    // Universal USB-C adapter insert
    color(color_insert)
        insert_universal_usbc();
    
    // Universal male terminator (plugged in)
    total_insert_depth = insert_base_depth + usbc_body_depth + uc_body_extension;
    color(color_terminator)
    translate([0, 0, total_insert_depth + 16])
    rotate([180, 0, 0])
        universal_male_terminator();
    
    // Cable visualization
    color("Black", 0.7)
    translate([0, 0, total_insert_depth + 20])
        cylinder(d=5, h=30, $fn=24);
}

// === CROSS-SECTION VIEW ===
module cross_section_view() {
    difference() {
        assembly_view();
        
        // Cut plane
        translate([0, -50, -10])
            cube([100, 100, 100]);
    }
    
    // PCB visualization (in cross-section)
    pcb_z = insert_base_depth + usbc_body_depth;
    color(color_pcb)
    translate([0, 0.1, pcb_z + pcb_cavity_depth/2])
        cube([pcb_cavity_width - 1, 0.1, pcb_cavity_depth - 1], center=true);
    
    // Contact pins visualization
    total_depth = insert_base_depth + usbc_body_depth + uc_body_extension;
    color(color_contacts)
    translate([0, 0.1, total_depth - 2])
        linear_extrude(0.1)
        for (col = [0:uc_pin_cols-1]) {
            x = (col - (uc_pin_cols-1)/2) * uc_pin_pitch;
            translate([x, 0])
                circle(d=0.6, $fn=8);
        }
}

// === ALL ADAPTER TYPES DISPLAY ===
module all_types_display() {
    spacing_x = 45;
    spacing_y = 35;
    
    // Labels (as comments in the model)
    // Row 1: Wide adapters
    translate([0, 0, 0]) {
        color(color_insert) insert_universal_usbc();
        // Label: USB-C
    }
    
    translate([spacing_x, 0, 0]) {
        color(color_insert) insert_universal_usba();
        // Label: USB-A
    }
    
    translate([spacing_x*2, 0, 0]) {
        color(color_insert) insert_universal_hdmi();
        // Label: HDMI
    }
    
    translate([spacing_x*3, 0, 0]) {
        color(color_insert) insert_universal_displayport();
        // Label: DisplayPort
    }
    
    // Row 2: Narrow adapters
    translate([0, -spacing_y, 0]) {
        color(color_insert) insert_universal_lightning_narrow();
        // Label: Lightning
    }
    
    translate([spacing_x/2, -spacing_y, 0]) {
        color(color_insert) insert_universal_audio_narrow();
        // Label: 3.5mm Audio
    }
    
    // Row 3: Universal components
    translate([spacing_x*1.5, -spacing_y, 0]) {
        color("DarkSlateGray") insert_universal_passthrough();
        // Label: Pass-Through (24-pin to 24-pin)
    }
    
    translate([spacing_x*2.5, -spacing_y, 0]) {
        color(color_terminator) universal_male_terminator();
        // Label: Universal Male Terminator
    }
    
    // Comparison: Original insert (no universal connector)
    translate([spacing_x*3.5, -spacing_y, 0]) {
        color("LightGray", 0.5) insert_usbc();
        // Label: Original Insert (for comparison)
    }
}

// === SIGNAL FLOW DIAGRAM (3D) ===
module signal_flow_demo() {
    // Shows how a cable connects through the system
    
    // 1. Device (simplified box)
    color("Navy", 0.5)
    translate([-60, 0, 8])
        cube([40, 30, 16], center=true);
    
    // 2. Original cable from device (e.g., HDMI)
    color("Black")
    translate([-35, 0, 8])
    rotate([0, 90, 0])
        cylinder(d=4, h=25, $fn=16);
    
    // 3. Universal adapter insert
    color(color_insert)
    translate([0, 0, 0])
        insert_universal_hdmi();
    
    // 4. Universal cable
    total_depth = insert_base_depth + hdmi_body_depth + uc_body_extension;
    color("Orange")
    translate([0, 0, total_depth + 5])
        cylinder(d=5, h=40, $fn=24);
    
    // 5. Universal male terminator (at other end)
    color(color_terminator)
    translate([0, 0, total_depth + 50])
        universal_male_terminator();
    
    // 6. Another adapter insert (e.g., USB-C)
    color(color_insert)
    translate([0, 0, total_depth + 50 + 20])
    rotate([180, 0, 0])
        insert_universal_usbc();
    
    // 7. Target device
    color("DarkRed", 0.5)
    translate([60, 0, total_depth + 70])
        cube([40, 30, 16], center=true);
    
    // Annotations would go here in a real diagram
}

// === MAIN RENDER ===
if (show_cross_section) {
    cross_section_view();
} else if (show_all_types) {
    all_types_display();
} else if (show_assembly) {
    assembly_view();
} else {
    // Default: signal flow demo
    signal_flow_demo();
}

// === QUICK REFERENCE ===
// To render different views, change the boolean flags above:
// - show_cross_section = true  → Internal structure view
// - show_assembly = true       → Insert + terminator mated
// - show_all_types = true      → All adapter variants
// - All false                  → Signal flow demonstration
