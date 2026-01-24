// ============================================
// USB-C FEMALE INSERT
// Port: 8.4mm x 2.6mm rounded rectangle
// ============================================

include <insert_base.scad>

module insert_usbc() {
    insert_with_port() port_usbc();
}

// Render
insert_usbc();
