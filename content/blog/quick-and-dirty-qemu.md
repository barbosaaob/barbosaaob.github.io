title: Quick and dirty guide to QEMU
tags: comp
category: comp
date: 2018-06-11
modified: 2018-06-11
status: draft

# create disk.img with 10G
qemu-img create disk.img 10G
# start amd64 system using disk.img, booting from first cdrom (-boot d), cdrom set to cd.iso and 512m of memory
qemu-system-amd64 -hda disk.img -boot d -cdrom cd.iso -m 512
