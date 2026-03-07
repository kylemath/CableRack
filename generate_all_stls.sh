#!/bin/bash
# ============================================
# Generate all STL files from SCAD sources
# ============================================

echo "Generating individual insert STLs..."

# Individual inserts
openscad -o print/print_insert_usba.stl print_insert_usba.scad &
openscad -o print/print_insert_usbc.stl print_insert_usbc.scad &
openscad -o print/print_insert_usb_mini.stl print_insert_usb_mini.scad &
openscad -o print/print_insert_micro.stl print_insert_micro.scad &
openscad -o print/print_insert_usb_b.stl print_insert_usb_b.scad &
openscad -o print/print_insert_lightning.stl print_insert_lightning.scad &
openscad -o print/print_insert_hdmi.stl print_insert_hdmi.scad &
openscad -o print/print_insert_audio_jack.stl print_insert_audio_jack.scad &
openscad -o print/print_insert_blank.stl print_insert_blank.scad &
openscad -o print/print_insert_blank_label.stl print_insert_blank_label.scad &
openscad -o print/print_insert_mount.stl print_insert_mount.scad &
openscad -o print/print_insert_mount_narrow.stl print_insert_mount_narrow.scad &

echo "Generating test sets..."
openscad -o print/print_test_set.stl print_test_set.scad &
openscad -o print/print_test_all_connectors.stl print_test_all_connectors.scad &

echo "Generating frames..."
openscad -o print/print_frame_single.stl print_frame_single.scad &
openscad -o print/print_frame_2x2.stl print_frame_2x2.scad &
openscad -o print/print_frame_3x3.stl print_frame_3x3.scad &

wait
echo "✓ All STL files generated!"
