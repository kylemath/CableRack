// ============================================
// PRINT FILE: Complete Connector Test Set
// ============================================
// Contains all 7 connector inserts for testing fit
// (USB-C excluded - already tested and confirmed good)
//
// Included:
// - USB-A
// - USB Mini
// - USB Micro (UPDATED dimensions)
// - USB-B
// - Lightning (UPDATED dimensions)
// - HDMI
// - 3.5mm Audio Jack
//
// All inserts printed port-side down for best quality
// ============================================

include <parameters.scad>
include <insert_base.scad>

// ============================================
// PRINT LAYOUT
// ============================================
// Arrange all 7 inserts in a neat grid

spacing = 40;  // Space between inserts

// Row 1 - USB connectors
translate([-spacing*1.5, spacing, 0])
    rotate([180, 0, 0])
    translate([0, 0, -insert_total_depth])
    insert_usba();

translate([-spacing*0.5, spacing, 0])
    rotate([180, 0, 0])
    translate([0, 0, -insert_total_depth])
    insert_usb_mini();

translate([spacing*0.5, spacing, 0])
    rotate([180, 0, 0])
    translate([0, 0, -insert_total_depth])
    insert_usb_micro();

translate([spacing*1.5, spacing, 0])
    rotate([180, 0, 0])
    translate([0, 0, -insert_total_depth])
    insert_usb_b();

// Row 2 - Other connectors
translate([-spacing, -spacing, 0])
    rotate([180, 0, 0])
    translate([0, 0, -insert_total_depth])
    insert_lightning();

translate([0, -spacing, 0])
    rotate([180, 0, 0])
    translate([0, 0, -insert_total_depth])
    insert_hdmi();

translate([spacing, -spacing, 0])
    rotate([180, 0, 0])
    translate([0, 0, -insert_total_depth])
    insert_audio_jack();
