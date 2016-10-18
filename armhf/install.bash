#!/bin/bash

HDA=hda1.qcow2
#SWAP=/run/shm/swap.qcow2
INITRD=install-initrd.gz
KERNEL=install-vmlinuz
DTB=vexpress-v2p-ca9.dtb
APPEND="root=/dev/ram console=ttyAMA0 earlycon"

qemu-system-arm \
    -M vexpress-a9 \
    -cpu cortex-a9 \
    -initrd $INITRD \
    -kernel $KERNEL \
    -dtb $DTB \
    -m 1024 \
    -sd $HDA \
    -append "$APPEND" \
    -no-reboot \
    -nographic
