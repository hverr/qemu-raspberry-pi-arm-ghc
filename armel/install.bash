#!/bin/bash

HDA=hda1.qcow2
#SWAP=/run/shm/swap.qcow2
INITRD=install-initrd.gz
KERNEL=install-vmlinuz
APPEND="root=/dev/ram console=ttyAMA0 earlycon"

qemu-system-arm \
    -M versatilepb \
    -initrd $INITRD \
    -kernel $KERNEL \
    -m 256 \
    -hda $HDA \
    -append "$APPEND" \
    -no-reboot \
    -nographic
