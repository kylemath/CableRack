// ============================================
// PRINT FILE: 10x20 Frame (200 slots) - MAXIMUM SIZE
// ============================================
// Print with back side down (no supports needed)
// Frame size: ~340.5mm x 336.5mm
// Fits on 350x350mm bed (maximum size!)
// ============================================

include <frame_module.scad>

// Render 10x20 frame (200 slots) - Maximum for 350mm bed
grid_frame(cols=10, rows=20);
