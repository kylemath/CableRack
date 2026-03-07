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
mount_hole_dia = 4;  // M4 mounting holes (changed from M3 for common screw sizes)
countersink_dia = 8;  // Diameter of countersink for M4 screw heads
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
insert_body_depth = 15.5;  // Standardized depth (USB-B 15.26mm + 0.25mm buffer) - all inserts same height
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
usbc_body_depth = 15.5;  // Standardized depth (USB-B 15.26mm + 0.25mm buffer)
// NO RETENTION RIBS for USB-C (removed per user request)

// USB-A: 13.0 x 4.5mm (standard male USB-A height)
usba_w = 13.0;
usba_h = 4.5;  // Match actual male USB-A height
usba_r = 0.5;
usba_body_depth = 15.5;  // Standardized depth (USB-B 15.26mm + 0.25mm buffer)
usba_retention_rib_depth = 5.0;  // Distance from front (moved back 1mm so ribs don't break)
usba_retention_rib_size = 0.15;  // How far ribs protrude inward

// USB Mini: 6.9 x 3.0mm, male connector ~9mm
usb_mini_w = 6.9;
usb_mini_h = 3.0;
usb_mini_r = 0.5;
usb_mini_body_depth = 15.5;  // Standardized depth (USB-B 15.26mm + 0.25mm buffer)
usb_mini_retention_rib_depth = 3.5;  // Distance from front where retention ribs start
usb_mini_retention_rib_size = 0.125;  // Reduced to half (was 0.25)

// USB Micro-B: 7.4 x 1.8mm (wider to fit corners of trapezoid)
usb_micro_w = 7.4;  // Increased width for corners
usb_micro_h = 1.8;
usb_micro_r = 0.3;
usb_micro_body_depth = 15.5;  // Standardized depth (USB-B 15.26mm + 0.25mm buffer)
usb_micro_retention_rib_depth = 4.5;  // Distance from front (moved back 1mm so ribs don't break)
usb_micro_retention_rib_size = 0.125;  // How far ribs protrude inward

// USB-B: 8.75 x 7.78mm (standard male USB-B height)
usb_b_w = 8.75;  // Width at bottom (wider)
usb_b_h = 7.78;  // Match actual male USB-B height (reduced from 7.9)
usb_b_r = 0.6;   // Corner radius
usb_b_top_inset = 0.9;  // How much narrower the top is (creates trapezoid shape)
usb_b_body_depth = 15.5;  // Standardized depth (15.26mm connector + 0.25mm buffer)
usb_b_retention_rib_depth = 5.5;  // Distance from front (moved back 1mm so ribs don't break)
usb_b_retention_rib_size = 0.15;  // How far ribs protrude inward

// Lightning: 7.6 x 1.5mm, male connector ~8mm (measured from actual connector)
lightning_w = 7.6;
lightning_h = 1.5;
lightning_r = 0.5;
lightning_body_depth = 15.5;  // Standardized depth (USB-B 15.26mm + 0.25mm buffer)
lightning_retention_rib_depth = 4.0;  // Distance from front (moved back 1mm so ribs don't break)
lightning_retention_rib_size = 0.1;   // How far ribs protrude inward

// HDMI: 14.65 x 4.45mm (standard male HDMI height)
hdmi_w = 14.65;
hdmi_h = 4.45;  // Match actual male HDMI height
hdmi_r = 0.5;
hdmi_body_depth = 15.5;  // Standardized depth (USB-B 15.26mm + 0.25mm buffer)
hdmi_retention_rib_depth = 6.0;  // Distance from front (moved back 1mm so ribs don't break)
hdmi_retention_rib_size = 0.1;   // How far ribs protrude inward

// 3.5mm Audio Jack: standard 3.5mm (1/8") diameter
audio_jack_dia = 3.6;  // 3.5mm + 0.1mm for less snug fit
audio_jack_body_depth = 15.5;  // Standardized depth (USB-B 15.26mm + 0.25mm buffer)
// Ring positions for TRS/TRRS ribs (tip, ring1, ring2 from front)
audio_jack_ring1 = 3.5;  // First ring position from front
audio_jack_ring2 = 6.5;  // Second ring position from front

// Blank/Label: recessed area for label
label_w = 30;
label_h = 12;
label_depth = 0.8;

// Keyhole mounting slot: picture-hanger style for wall/table mounting
// The keyhole allows a round-headed screw to pass through, then lock in slot
keyhole_head_dia = 6;   // Diameter for screw head to pass through (5% narrower, fits #6-#8 wood screws)
keyhole_slot_width = 3.5; // Width of slot for screw shaft
keyhole_slot_length = 5.3; // Travel distance to lock screw in place
keyhole_depth = 2.5;      // Depth of keyhole cut (allows screw head to sit below surface)

// AC Power Plug: asymmetric holes for polarity (US 2-prong)
// Prongs are VERTICAL (tall and thin)
// Hot prong (narrower): 1.6mm wide x 6.5mm tall
// Neutral prong (wider): 1.6mm wide x 8.5mm tall (increased)
power_hot_w = 1.6;   // Width (thin dimension)
power_hot_h = 6.5;   // Height (tall dimension)
power_neutral_w = 1.6;   // Width (thin dimension)
power_neutral_h = 8.5;   // Height (tall dimension, increased from 8.1)
power_prong_spacing = 12.7;  // 0.5" center-to-center
power_body_depth = 15.5;  // Standardized depth (USB-B 15.26mm + 0.25mm buffer)

// === CALCULATED VALUES ===
frame_total_depth = frame_back + slot_depth;
grid_width = (grid_cols * slot_width) + ((grid_cols - 1) * frame_wall);
grid_height = (grid_rows * slot_height) + ((grid_rows - 1) * frame_wall);
frame_width = grid_width + (2 * frame_border);
frame_height_total = grid_height + (2 * frame_border);
insert_total_depth = insert_base_depth + insert_body_depth;
