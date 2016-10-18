Build Haskell projects for Raspberry Pi using QEMU
==================================================

[Click here for armel instructions](/armel/README.md)

This repository allows you to create a fully simulated ARMv7 (armhf) evironment with QEMU that can compile Haskell and Cabal projects for Raspberry Pi 2 or other ARMv7 hardware.

After this tutorial you'll have a simulated ARMv7 machines running Debian Jessie with GHC 7.10.3 and Cabal 1.22.*.

## Dependencies

You'll need `qemu-system-arm` and other QEMU utilities. Either by installing them using your package manager or compiling them yourself.

## Building the VM

Create a hard drive for your VM.

    qemu-img create -f qcow2 hda1.qcow2 20G

Use the netboot kernel to do a network installation of Debian Jessie. Follow the instructions in your terminal.

    curl -L http://ftp.debian.org/debian/dists/jessie/main/installer-armhf/current/images/netboot/initrd.gz -o install-initrd.gz
	curl -L http://ftp.debian.org/debian/dists/jessie/main/installer-armhf/current/images/netboot/vmlinuz -o install-vmlinuz
	curl -L http://ftp.debian.org/debian/dists/jessie/main/installer-armhf/current/images/device-tree/vexpress-v2p-ca9.dtb -o vexpress-v2p-ca9.dtb
	./install.bash

## Running the VM

To run the VM you just created, you need to extract the initramfs and the kernel from the `hda1.qcow2` file. Use `qemu-nbd` to extract the kernel.

    modprobe nbd max_part=63
	qemu-nbd -c /dev/nbd0 hda1.qcow
	mount /dev/nbd0p1 /mnt
	cp /mnt/initrd.img-3.16.0-4-armmp ./
	cp /mnt/vmlinuz-3.16.0-4-armmp ./
	umount /dev/nbd0p1

QEMU can only give your VM 1024 of RAM, it is not possible to add another disk as swap, as QEMU only supports one SD-card.

Now boot the VM and login

    ./run.bash

## Installing GHC 7.10.3

Debian Jessie has GHC 7.6.3 in its stable distribution. However, the testing repository contains GHC 7.10.3.

Enable the testing repository in `/etc/apt/sources.list`

    ...
	deb http://ftp.belnet.be/debian/ testing main
	deb-src http://ftp.belnet.be/debian/ testing main
	...

Now pin the `ghc` and `cabal-install` packages in `/etc/apt/preferences.d/ghc`

    Package: *
	    Pin: release a=stable
    
	Package: ghc
	    Pin: release a=testing
    
	Package: cabal-install
	    Pin: release a=testing

Now install the packages after ensuring the correct version

    apt-get update
	apt-cache show ghc
	apt-get install ghc cabal-install
