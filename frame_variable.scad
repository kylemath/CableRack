// ============================================
// FRAME WITH VARIABLE WIDTH COLUMNS
// ============================================
// Supports mixed narrow and wide slots
// ============================================

include <parameters.scad>
include <insert_base.scad>

// === VARIABLE WIDTH FRAME MODULE ===
// col_widths: array of widths for each column [slot_width, slot_width_narrow, slot_width, ...]
// rows: number of rows (all rows have same height)
module grid_frame_variable(col_widths, rows) {
    // Calculate total grid dimensions
    total_cols = len(col_widths);
    total_width = sum_array(col_widths) + ((total_cols - 1) * frame_wall);
    total_height = (rows * slot_height) + ((rows - 1) * frame_wall);
    local_frame_width = total_width + (2 * frame_border);
    local_frame_height = total_height + (2 * frame_border);
    
    difference() {
        rounded_box_rect(local_frame_width, local_frame_height, frame_total_depth, 3);
        translate([0, 0, frame_back]) slot_grid_variable(col_widths, rows);
        back_cutouts_variable(col_widths, rows);
        mounting_holes(local_frame_width, local_frame_height);
    }
}

// === VARIABLE WIDTH SLOT GRID ===
module slot_grid_variable(col_widths, rows) {
    total_cols = len(col_widths);
    
    for (col = [0 : total_cols-1], row = [0 : rows-1]) {
        // Calculate x position based on accumulated widths
        x = get_col_x_position(col_widths, col, total_cols);
        y = (row - (rows-1)/2) * (slot_height + frame_wall);
        w = col_widths[col];
        
        translate([x, y, 0]) slot_recess_variable(w);
    }
}

// === VARIABLE WIDTH SLOT RECESS ===
module slot_recess_variable(width) {
    translate([0, 0, slot_depth/2 + 0.1])
        cube([width, slot_height, slot_depth + 0.2], center=true);
}

// === VARIABLE WIDTH BACK CUTOUTS ===
module back_cutouts_variable(col_widths, rows) {
    total_cols = len(col_widths);
    
    for (col = [0 : total_cols-1], row = [0 : rows-1]) {
        x = get_col_x_position(col_widths, col, total_cols);
        y = (row - (rows-1)/2) * (slot_height + frame_wall);
        w = col_widths[col];
        
        // Cutout size depends on slot width
        cutout_w = (w == slot_width_narrow) 
            ? insert_body_width_narrow + 2*clearance 
            : insert_body_width + 2*clearance;
        cutout_h = insert_body_height + 2*clearance;
        
        translate([x, y, -0.1])
            rounded_box_rect(cutout_w, cutout_h, frame_back + 0.2, 1);
    }
}

// === HELPER FUNCTIONS ===

// Calculate X position for a column based on accumulated widths
function get_col_x_position(col_widths, col, total_cols) = 
    let(
        // Sum of all widths up to (but not including) this column
        width_before = sum_array_range(col_widths, 0, col),
        // Add frame walls between columns before this one
        walls_before = col * frame_wall,
        // Total width of all columns
        total_width = sum_array(col_widths) + ((total_cols - 1) * frame_wall),
        // Position relative to center, plus half of this column's width
        offset_from_center = width_before + walls_before - total_width/2 + col_widths[col]/2
    )
    offset_from_center;

// Sum all elements in an array
function sum_array(arr, i=0) = 
    i >= len(arr) ? 0 : arr[i] + sum_array(arr, i+1);

// Sum elements in array from index start to end-1
function sum_array_range(arr, start, end) =
    start >= end ? 0 : arr[start] + sum_array_range(arr, start+1, end);

// === MOUNTING HOLES (same as standard frame) ===
module mounting_holes(fw, fh) {
    hx = fw/2 - frame_border/2 - 1;
    hy = fh/2 - frame_border/2 - 1;
    for (xm = [-1, 1], ym = [-1, 1]) {
        translate([xm * hx, ym * hy, -0.1]) {
            // Through hole for screw shaft
            cylinder(d=mount_hole_dia, h=frame_total_depth + 0.2);
            // Countersink on back face (mounting surface)
            cylinder(d1=countersink_dia, d2=mount_hole_dia, h=countersink_depth);
        }
    }
}

// === CONVENIENCE CONSTANTS FOR COLUMN WIDTHS ===
W = slot_width;         // Wide slot
N = slot_width_narrow;  // Narrow slot
