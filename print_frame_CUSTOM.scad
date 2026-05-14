// ============================================
// PRINT FILE: Custom Size Frame
// ============================================
// Edit the cols and rows values below to create any size frame
// Print with back side down (no supports needed)
// 
// Frame size calculator:
// Width  = (cols × 32.5) + 16 mm
// Height = (rows × 16.5) + 16 mm
//
// 350x350mm bed maximum:
// - Max columns: 10 (340.5mm wide)
// - Max rows: 20 (345.5mm tall)
// ============================================

include <frame_module.scad>

// === EDIT THESE VALUES ===
cols = 5;   // Number of columns (1-10 for 350mm bed)
rows = 10;  // Number of rows (1-20 for 350mm bed)
// =========================

// Render custom frame
grid_frame(cols=cols, rows=rows);

// Frame dimensions preview (visible in console)
echo(str("Frame slots: ", cols, " × ", rows, " = ", cols*rows, " slots"));
echo(str("Frame width: ~", (cols * 32.5) + 16, "mm"));
echo(str("Frame height: ~", (rows * 16.5) + 16, "mm"));
