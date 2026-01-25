// ============================================
// PRINT FILE: Mixed Frame - 2 Narrow + 1 Wide (2 rows)
// ============================================
// 3 columns x 2 rows = 6 slots
// Columns: Narrow, Narrow, Wide
// Good for: USB-C, Lightning, HDMI
// Print with back side down (no supports needed)
// ============================================

include <frame_variable.scad>

// Column widths: N=narrow (16mm), W=wide (32mm)
col_widths = [N, N, W];
rows = 2;

// Render
grid_frame_variable(col_widths, rows);
