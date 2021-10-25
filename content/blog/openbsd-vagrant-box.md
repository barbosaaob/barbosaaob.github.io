title: Creating an OpenBSD Vagrant box for libvirt
tags: comp
category: blog
date: 2021-10-24 18:04
modified: 2021-10-24 21:27

# install

Create disk image:

    $ qemu-img create -f qcow2 openbsd70.qcow2 128G
    Formatting 'openbsd70.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=137438953472 lazy_refcounts=off refcount_bits=16

Proceed with your prefered install options using QEMU. As the default QEMU
console was repeating keystrokes, I changed to the serial console during
OpenBSD boot

    >> OpenBSD/amd64 CDBOOT 3.53
    boot> set tty com0
    switching console to com0

and changed the view on `View->Consoles->Serial 1` menu on QEMU.

After the install process we need to do some post install configuration.

# post install config

Download Vagrant ssh key and add to the `authorized_keys` file:

    $ ftp https://adrianobarbosa.xyz/pub/vagrant-ssh-key
    $ cat vagrant-ssh-key >> /mnt/home/vagrant/.ssh/authorized_keys

The file content is:

    ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key

This is an insecure public key which will be used by Vagrant on the first
access and replaced later.

Create `hostname.if` depending on the network interface:

    $ echo "autoconf" > /mnt/etc/hostname.vio0
    $ echo "autoconf" > /mnt/etc/hostname.em0
    $ echo "autoconf" > /mnt/etc/hostname.run0
    $ echo "autoconf" > /mnt/etc/hostname.hvn0

We are good to shutdown now.

# creating the box

I used the `create_box.sh` from the [vagrant-libvirt
repository](https://github.com/vagrant-libvirt/vagrant-libvirt).

Create the `Vagrantfile` with at least these two lines and any other
config you wish:

    Vagrant.configure("2") do |config|
        config.ssh.shell = "ksh"
        config.vm.synced_folder ".", "/vagrant", disabled: true
    end

Creating the box:

    $ create_box.sh openbsd70.qcow2 openbsd70.box Vagrantfile
    ==> Creating box, tarring and gzipping
    ./metadata.json
    ./Vagrantfile
    ./box.img
    Total de bytes escritos: 3185121280 (3,0GiB, 189MiB/s)
    ==> openbsd70.box created
    ==> You can now add the box:
    ==>   'vagrant box add openbsd70.box --name openbsd70'

Adding the box to Vagrant:

    $ vagrant box add openbsd70.box --name openbsd70

# running the new machine

    $ vagrant init openbsd70
    $ vagrant up
