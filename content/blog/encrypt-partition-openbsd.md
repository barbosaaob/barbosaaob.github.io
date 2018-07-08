title: Encrypt partition in OpenBSD 6.3
category: blog
tags: comp
date: 2018-07-07 20:24
modified: 2018-07-07 20:24

This post is meant to guide througt encrypt a specific partition in OpenBSD
6.3. We will encrypt `/home` partition:

Umount `/home` partition

    # umount /home

Suppose your system is running on disk sdX.  Discover the identifier of `/home`
partition

    # disklabel -E sdX
    Label editor (enter '?' for help at ane prompt)
    > p g
    ...

in my disk the `/home` patition is `m:`.

Still in disklabel, change `/home` file system type

    > m m
    offset: [...]
    size: [...]
    FS type: [4.2BSD] RAID
    > w
    > q

Write random data to avoid data recovery and protect the encrypted data (this
can be a very time-consuming process, depending on the speed of your CPU and
disk, as well as the size of the disk)

    # dd if=/dev/random of=/dev/rsdXm bs=1m

Now we attach `sdXm` as a crypto volume

    # bioctl -c C -l /dev/sdXm softraid0
    New passphrase:
    Re-type passphrase:
    softraid0: CRYPTO volume attached as sdY

Note that our crypto volume is now identified as `sdY`.

Let's now zero the first megabyte of `sdY` to clean the master boot record and
disklabel 

    # dd if=/dev/zero of=/dev/rsdYc bs=1m count=1

Now we create a partition on `sdY`

    # fdisk -iy sdY
    # disklabel -E sdY
    Label editor (enter '?' for help at ane prompt)
    > a
    ...
    
Format the partition

    # newfs /dev/rsdYa

Delete or comment `/home` entry in `/etc/fstab`.

Get the disks uid

    # disklabel sdX | grep uid
    duid: 123abc
    # disklabel sdY | grep uid
    duid: 789xyz

We need to mount the crypto volume during the boot. Add the following lines to
start up script `/etc/rc.local`

    for i in 1 2 3; do  # tries to mount 3 times
        bioctl -c C -l 123abc.m softraid0 && break  # attach sdXm as crypto volume
        sleep 2  # wait 2 seconds between tries
    done
    fsck /dev/rsdYa  # check crypto volume fs for error
    mount -o rw,nodev,nosuid,softdep 789xyz.a /home  # mount partition

And we are done! Your system is ready to boot with the `/home` partition
enctypted and ready to mount at boot.

Last note: `/home` partition is completelly empty, so if you have any user other
than root on your system, you need to create each user directory and set the
right permitions.
