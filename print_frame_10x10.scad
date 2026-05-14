// ============================================
// PRINT FILE: 10x10 Frame (100 slots)
// ============================================
// Print with back side down (no supports needed)
// Frame size: ~340.5mm x 176.5mm
// Fits on 350x350mm bed
// ============================================

include <frame_module.scad>

// Render 10x10 frame (100 slots)
grid_frame(cols=10, rows=10);
