// ============================================
// PRINT FILE: 3.5mm Audio Jack Insert
// ============================================
// Body depth: 14mm (matches 3.5mm male plug)
// Print with port side DOWN (flat on bed)
// No supports needed - through-hole design
// ============================================

include <parameters.scad>
include <insert_base.scad>

// Audio Jack insert - oriented for printing (port side down)
total_depth = insert_base_depth + audio_jack_body_depth;

rotate([180, 0, 0])
translate([0, 0, -total_depth])
    insert_audio_jack();
