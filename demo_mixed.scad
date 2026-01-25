// ============================================
// MODULAR CABLE ORGANIZER - MIXED WIDTH DEMO
// ============================================
// Shows frame with narrow + wide slots and inserts
// Open in OpenSCAD and press F5 to preview
// ============================================

// === DEMO OPTIONS ===
show_cutaway = true;  // Set to true to show cutaway view of insert fitting

include <parameters.scad>
include <insert_base.scad>
include <frame_variable.scad>

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

// ============================================
// DEMO LAYOUT
// ============================================

// === ASSEMBLED MIXED FRAME (2 narrow + 2 wide, 2 rows = 8 slots) ===
// Configuration: Narrow, Narrow, Wide, Wide
// Inserts are flipped 180° - narrow neck goes through back, wide base visible from front
translate([-80, 0, 0]) {
    difference() {
        union() {
            // Frame with mixed widths: N, N, W, W
            col_widths = [N, N, W, W];
            rows = 2;
            color("DimGray", 0.85) grid_frame_variable(col_widths, rows);
            
            // Calculate positions for inserts (matching frame_variable.scad logic)
            // Column widths: N, N, W, W
            total_width = N + N + W + W + 3*frame_wall;
            
            // Calculate x positions for each column
            x_col0 = -total_width/2 + N/2;
            x_col1 = -total_width/2 + N + frame_wall + N/2;
            x_col2 = -total_width/2 + N + frame_wall + N + frame_wall + W/2;
            x_col3 = -total_width/2 + N + frame_wall + N + frame_wall + W + frame_wall + W/2;
            
            // Row positions (standard)
            y_top = (slot_height + frame_wall)/2;
            y_bottom = -(slot_height + frame_wall)/2;
            
            // TOP ROW (4 inserts)
            // Col 0 (Narrow): USB-C narrow
            translate([x_col0, y_top, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("SteelBlue") insert_usbc_narrow();
            
            // Col 1 (Narrow): Lightning narrow
            translate([x_col1, y_top, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("Tomato") insert_lightning_narrow();
            
            // Col 2 (Wide): USB-A standard
            translate([x_col2, y_top, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("Coral") insert_usba();
            
            // Col 3 (Wide): HDMI standard
            translate([x_col3, y_top, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("MediumSeaGreen") insert_hdmi();
            
            // BOTTOM ROW (4 inserts)
            // Col 0 (Narrow): Audio Jack narrow
            translate([x_col0, y_bottom, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("LimeGreen") insert_audio_jack_narrow();
            
            // Col 1 (Narrow): USB-B narrow (printer/keyboard style)
            translate([x_col1, y_bottom, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("Goldenrod") insert_usb_b_narrow();
            
            // Col 2 (Wide): USB-A standard (the big rectangular one)
            translate([x_col2, y_bottom, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("Coral") insert_usba();
            
            // Col 3 (Wide): Blank/Label standard
            translate([x_col3, y_bottom, frame_back + insert_base_depth])
                rotate([180, 0, 0])
                color("Silver") insert_blank_label();
        }
        
        // OPTIONAL CUTAWAY: Cut corner to show cross-section (controlled by show_cutaway flag)
        if (show_cutaway) {
            translate([x_col0 - 40, y_bottom - 32, -30])
                cube([40, 30, 40]);
        }
    }
}

// === COMPARISON: NARROW vs WIDE INSERTS (side by side) ===
// Show same connector types in narrow and wide versions

sx = 50;   // Start X
sp = 25;   // Spacing for narrow
spy = 30;  // Y spacing

// Calculate total depths
usbc_total = get_total_depth(usbc_body_depth);
lightning_total = get_total_depth(lightning_body_depth);
usb_micro_total = get_total_depth(usb_micro_body_depth);
usb_b_total = get_total_depth(usb_b_body_depth);
audio_jack_total = get_total_depth(audio_jack_body_depth);

// Row 1: USB-C comparison (wide vs narrow)
translate([sx + 0*sp, 2*spy, usbc_total]) rotate([180, 0, 0]) color("SteelBlue") insert_usbc();
translate([sx + 1*sp, 2*spy, usbc_total]) rotate([180, 0, 0]) color("SteelBlue", 0.7) insert_usbc_narrow();

// Row 2: Lightning comparison (wide vs narrow)
translate([sx + 0*sp, spy, lightning_total]) rotate([180, 0, 0]) color("Tomato") insert_lightning();
translate([sx + 1*sp, spy, lightning_total]) rotate([180, 0, 0]) color("Tomato", 0.7) insert_lightning_narrow();

// Row 3: USB Micro comparison (wide vs narrow)
translate([sx + 0*sp, 0, usb_micro_total]) rotate([180, 0, 0]) color("Orchid") insert_usb_micro();
translate([sx + 1*sp, 0, usb_micro_total]) rotate([180, 0, 0]) color("Orchid", 0.7) insert_usb_micro_narrow();

// Row 4: USB-B comparison (wide vs narrow) - printer/keyboard style
translate([sx + 0*sp, -spy, usb_b_total]) rotate([180, 0, 0]) color("Goldenrod") insert_usb_b();
translate([sx + 1*sp, -spy, usb_b_total]) rotate([180, 0, 0]) color("Goldenrod", 0.7) insert_usb_b_narrow();

// Row 5: Audio Jack comparison (wide vs narrow)
translate([sx + 0*sp, -2*spy, audio_jack_total]) rotate([180, 0, 0]) color("LimeGreen") insert_audio_jack();
translate([sx + 1*sp, -2*spy, audio_jack_total]) rotate([180, 0, 0]) color("LimeGreen", 0.7) insert_audio_jack_narrow();

// ============================================
// LEGEND
// ============================================
// LEFT: Mixed frame (N, N, W, W) with 8 inserts
//   Top row: USB-C(N), Lightning(N), USB-A(W), HDMI(W)
//   Bottom row: Audio Jack(N), USB-B(N), USB-A(W), Label(W)
//
// RIGHT: Size comparison (Wide vs Narrow) - 5 rows
//   Row 1: USB-C | Row 2: Lightning | Row 3: USB-Micro
//   Row 4: USB-B (printer style) | Row 5: Audio Jack
//   Narrow versions for small connectors only
//   USB-A stays WIDE (it's the big rectangular connector)
//   Narrow inserts are 50% narrower (16mm vs 32mm)
