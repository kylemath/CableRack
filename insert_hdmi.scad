// ============================================
// HDMI FEMALE INSERT
// Port: 14.0mm x 4.5mm tapered shape
// ============================================

include <insert_base.scad>

module insert_hdmi() {
    insert_with_port() port_hdmi();
}

// Render
insert_hdmi();
