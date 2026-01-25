// ============================================
// PRINT FILE: All Narrow Frame - 4 Narrow (2 rows)
// ============================================
// 4 columns x 2 rows = 8 slots
// Columns: All Narrow
// Good for: USB-C, USB-A, Lightning, Micro-USB, Audio
// Compact and space-efficient
// Print with back side down (no supports needed)
// ============================================

include <frame_variable.scad>

// Column widths: N=narrow (16mm), W=wide (32mm)
col_widths = [N, N, N, N];
rows = 2;

// Render
grid_frame_variable(col_widths, rows);
