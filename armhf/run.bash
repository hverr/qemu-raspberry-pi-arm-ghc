#!/bin/bash

HDA=hda1.qcow2
SWAP=/run/shm/swap.qcow2
INITRD=initrd.img-3.16.0-4-armmp
KERNEL=vmlinuz-3.16.0-4-armmp
DTB=vexpress-v2p-ca9.dtb
APPEND="root=/dev/mmcblk0p2 console=ttyAMA0"

qemu-system-arm \
    -M vexpress-a9 \
    -cpu cortex-a9 \
    -dtb $DTB \
    -initrd $INITRD \
    -kernel $KERNEL \
    -m 1024 \
    -sd $HDA \
    -append "$APPEND" \
    -no-reboot \
    -nographic