// ============================================
// PRINT FILE: Mixed Frame - Alternating N/W (2 rows)
// ============================================
// 4 columns x 2 rows = 8 slots
// Columns: Narrow, Wide, Narrow, Wide
// Alternating pattern for varied cable types
// Print with back side down (no supports needed)
// ============================================

include <frame_variable.scad>

// Column widths: N=narrow (16mm), W=wide (32mm)
col_widths = [N, W, N, W];
rows = 2;

// Render
grid_frame_variable(col_widths, rows);
