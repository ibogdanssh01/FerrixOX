#!/bin/bash
set -e

# ==== CONFIG ====
KERNEL_PACKAGE=kernel
TARGET_JSON=kernel/i386-unknown-none.json
TARGET=i386-unknown-none
KERNEL_BINARY=target/$TARGET/release/kernel
ISO_DIR=iso
GRUB_CFG=boot/grub/grub.cfg
OUTPUT_ISO=FerrixOX.iso

echo "[1/5] Building kernel ($KERNEL_PACKAGE)..."
cargo build --release --package $KERNEL_PACKAGE --target $TARGET_JSON

echo "[2/5] Creating ISO structure..."
rm -rf $ISO_DIR
mkdir -p $ISO_DIR/boot/grub

echo "[3/5] Copying kernel and GRUB config..."
cp $KERNEL_BINARY $ISO_DIR/boot/kernel
cp $GRUB_CFG $ISO_DIR/boot/grub/grub.cfg

echo "[4/5] Creating bootable ISO with GRUB..."
grub-mkrescue -o $OUTPUT_ISO $ISO_DIR

echo "[5/5] Done! ✅ ISO created at $OUTPUT_ISO"
