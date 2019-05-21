title: OpenBSD 6.5 arm64 (aarch64) on QEMU
tags: comp
category: blog
date: 2019-05-19 17:02
modified: 2019-05-20 20:20

## Using OpenBSD 6.5 arm64 (aarch64) on QEMU

Install QEMU

    doas pkg_add qemu

Download QEMU EFI

    ftp http://releases.linaro.org/components/kernel/uefi-linaro/latest/release/qemu64/QEMU_EFI.fd 

Download OpenBSD 6.5 arm64 install media

    ftp https://cdn.openbsd.org/pub/OpenBSD/6.5/arm64/miniroot65.fs

Create the disk image

    qemu-img create -f qcow2 obsd-arm64.qcow2 10G

Start the virtual machine

    qemu-system-aarch64 \
    -M virt \
    -m 512 \
    -cpu cortex-a57 \
    -bios QEMU_EFI.fd \
    -drive file=miniroot65.fs,format=raw,id=drive1 \
    -drive file=obsd-arm64.qcow2,if=none,id=drive0,format=qcow2 \
    -device virtio-blk-device,drive=drive0 \
    -nographic \
    -serial tcp::4450,server,telnet,wait

In another terminal, connect to the virtual machine serial console

    telnet localhost 4450

Follow OpenBSD install and finish the installation.

From now on we can start the virtual machine without the install media

    qemu-system-aarch64 \
    -M virt \
    -m 512 \
    -cpu cortex-a57 \
    -bios QEMU_EFI.fd \
    -drive file=obsd-arm64.qcow2,if=none,id=drive0,format=qcow2 \
    -device virtio-blk-device,drive=drive0 \
    -nographic \
    -serial tcp::4450,server,telnet,wait

Source: https://cryogenix.net/OpenBSD_arm64_qemu.html
