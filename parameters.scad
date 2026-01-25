// ============================================
// MODULAR CABLE ORGANIZER - SHARED PARAMETERS
// ============================================
// All dimensions in mm - include this in all files
// ============================================

$fn = 48;

// === TOLERANCES ===
clearance = 0.3;
port_clearance = 0.1;  // Extra clearance for port openings (reduced - 0.2 was too loose for USB-C)
wall = 1.6;

// === SLOT DIMENSIONS (2:1 aspect ratio) - scaled to 2/3 ===
slot_width = 32;  // Standard wide slot for larger connectors
slot_width_narrow = 16;  // Narrow slot for compact connectors (USB-C, micro-USB, USB-A, Lightning, 3.5mm)
slot_height = 16;  // Height is same for both wide and narrow
slot_depth = 4;  // Reduced from 6mm - less frame depth needed

// === FRAME STRUCTURE ===
frame_wall = 2.0;   // Wall between slots - 6 layers @ 0.4mm nozzle for strength
frame_border = 6;  // Increased by 10mm for mounting holes with countersink
frame_back = 2;     // Slightly thicker for snap catch strength
mount_hole_dia = 3;
countersink_dia = 6;  // Diameter of countersink for screw heads
countersink_depth = 2;  // Depth of countersink

// === DEFAULT GRID (can be overridden in individual files) ===
grid_cols = 2;
grid_rows = 2;

// === INSERT BASE DIMENSIONS ===
insert_width = slot_width - (2 * clearance);
insert_height = slot_height - (2 * clearance);
insert_base_depth = slot_depth - 0.5;

// === NARROW INSERT BASE DIMENSIONS ===
insert_width_narrow = slot_width_narrow - (2 * clearance);
insert_height_narrow = slot_height - (2 * clearance);

// === INSERT BODY (protrudes from frame) ===
insert_body_width = insert_width - 4;
insert_body_height = insert_height - 3;
insert_body_depth = 12;  // Deep enough to accommodate male cable connectors
insert_top_thick = 1.5;  // Top platform thickness

// === NARROW INSERT BODY (protrudes from frame) ===
insert_body_width_narrow = insert_width_narrow - 4;
insert_body_height_narrow = insert_height_narrow - 3;

// === SNAP TABS (on neck/body - catch on back plate) ===
snap_tab_width = 4;
snap_tab_protrude = 1.2;  // How far tab sticks out from body
snap_tab_thick = 1.5;     // Z thickness of tab
snap_tab_offset = 2.2;      // Distance from base to tab bottom on insert (increased to clear frame)

// === CONNECTOR PORT DIMENSIONS & BODY DEPTHS ===
// Port dimensions from reference blueprints
// Body depths sized to match typical male connector lengths

// USB-C: 8.4 x 2.6mm, male connector ~9mm
usbc_w = 8.4;
usbc_h = 2.6;
usbc_r = 1.0;
usbc_body_depth = 9;

// USB-A: 12.0 x 4.5mm (tighter fit based on test print)
usba_w = 12.0;
usba_h = 4.5;
usba_r = 0.5;
usba_body_depth = 13;

// USB Mini: 6.9 x 3.0mm, male connector ~9mm
usb_mini_w = 6.9;
usb_mini_h = 3.0;
usb_mini_r = 0.5;
usb_mini_body_depth = 9;

// USB Micro-B: 7.0 x 1.8mm (tighter fit based on test print)
usb_micro_w = 7.0;
usb_micro_h = 1.8;
usb_micro_r = 0.3;
usb_micro_body_depth = 7;

// USB-B: 8.4 x 7.6mm (printer/keyboard style connector)
usb_b_w = 8.4;
usb_b_h = 7.6;
usb_b_r = 0.8;
usb_b_body_depth = 14;

// Lightning: 7.6 x 1.5mm, male connector ~8mm (measured from actual connector)
lightning_w = 7.6;
lightning_h = 1.5;
lightning_r = 0.5;
lightning_body_depth = 8;

// HDMI: 13.9 x 4.45mm (adjusted taper for better fit)
hdmi_w = 13.9;
hdmi_h = 4.45;
hdmi_r = 0.5;
hdmi_body_depth = 16;

// 3.5mm Audio Jack: male plug ~14mm (3.5mm = ~3.5mm, but use 3.6mm for snug fit)
audio_jack_dia = 3.6;
audio_jack_body_depth = 14;

// Blank/Label: recessed area for label
label_w = 30;
label_h = 12;
label_depth = 0.8;

// === CALCULATED VALUES ===
frame_total_depth = frame_back + slot_depth;
grid_width = (grid_cols * slot_width) + ((grid_cols - 1) * frame_wall);
grid_height = (grid_rows * slot_height) + ((grid_rows - 1) * frame_wall);
frame_width = grid_width + (2 * frame_border);
frame_height_total = grid_height + (2 * frame_border);
insert_total_depth = insert_base_depth + insert_body_depth;
