// ============================================
// PRINT FILE: 8x15 Frame (120 slots)
// ============================================
// Print with back side down (no supports needed)
// Frame size: ~275mm x 256.5mm
// Good balance for 350x350mm bed
// ============================================

include <frame_module.scad>

// Render 8x15 frame (120 slots)
grid_frame(cols=8, rows=15);
