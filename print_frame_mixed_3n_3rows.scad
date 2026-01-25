// ============================================
// PRINT FILE: All Narrow Frame - 3x3 (9 slots)
// ============================================
// 3 columns x 3 rows = 9 slots
// Columns: All Narrow
// Compact 3x3 grid for maximum slot density
// Print with back side down (no supports needed)
// ============================================

include <frame_variable.scad>

// Column widths: N=narrow (16mm)
col_widths = [N, N, N];
rows = 3;

// Render
grid_frame_variable(col_widths, rows);
