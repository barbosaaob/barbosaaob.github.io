title: OpenBSD 6.3 live USB
tags: comp
category: blog
date: 2018-07-14 22:53
modified: 2018-07-14 22:53

## Using OpenBSD 6.3 and vmd(8)

Create the disk image

    vmctl create disk.img -s 4G

Start the virtual machine booting bsd.rd kernel, `disk.img` as disk,
`install63.iso` as cdrom and 512M of memory

    vmctl start "live" -b /bsd.rd -d disk.img -r /path/to/install63.iso -m 512M

Follow OpenBSD install, but when asked if you would like to change default
console answer `no`

    Change the default console to com0? [yes] no

and finish the installation.

Now we are ready to `dd(1)` the disk to our USB stick `rsdX`

    dd if=disk.img of=/dev/rsdXc bs=1m

The USB stick is ready to boot.

## Using GNU/Linux and QEMU

Create `disk.img`

    qemu-img create disk.img 4G

Start a virtual machine using `disk.img` as hard drive, booting from first
cdrom, `install63.iso` as cdrom and 512M of memory

    qemu-system-x86_64 -hda disk.img -boot d -cdrom /path/to/install63.iso -m 512

Follow OpenBSD install to the end.

Now we are ready to `dd(1)` the disk to our USB stick `sdX`

    dd if=disk.img of=/dev/sdX bs=1M

The USB stick is now ready to boot.
