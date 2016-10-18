#!/bin/bash

HDA=hda1.qcow2
SWAP=/run/shm/swap.qcow2
INITRD=initrd.img-3.16.0-4-versatile
KERNEL=vmlinuz-3.16.0-4-versatile
APPEND="root=/dev/sda1 console=ttyAMA0"

qemu-system-arm \
    -M versatilepb \
    -initrd $INITRD \
    -kernel $KERNEL \
    -m 256 \
    -hda $HDA \
    -hdb $SWAP \
    -append "$APPEND" \
    -no-reboot \
    -nographic