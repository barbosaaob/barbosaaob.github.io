title: Creating a Debian Vagrant box for libvirt
tags: comp
category: blog
date: 2023-06-12 19:53
modified: 2023-06-12 19:53

# install

Create disk image:

    $ qemu-img create -f qcow2 debian12.qcow2 128G

Proceed with your prefered install options using QEMU. I created a regular
user called vagrant during the install.

# post install config

On the guest machine, add user vagrant to sudoers:

    $ sudo sh -c 'echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vagrant'
    $ chmod 440 /etc/sudoers.d/vagrant

Change the network interface name to legacy style by adding  `net.ifnames=0` to `/etc/default/grub` in `GRUB_CMDLINE_LINUX` variable. Update grub:

    $ sudo update-grub2

Edit network settings in `/etc/network/interfaces`

    allow-hotplug eth0
    iface eth0 inet dhcp

Lock user vagrant password. We will login using ssh keys

    $ sudo passwd -l vagrant

Clean history and shutdown the guest:

    $ history -c

On the host machine, download Vagrant ssh key:

    $ curl -L https://adrianobarbosa.xyz/pub/vagrant-ssh-key -O vagrant-ssh-key

The file content is:

    ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key

This is an insecure public key which will be used by Vagrant on the first
access and replaced later.

Reset ssh guest server keys and inject vagrant public key:

    $ sudo virt-sysprep -d debian12 --ssh-inject vagrant:file:vagrant-ssh-key --firstboot-command "dpkg-reconfigure openssh-server"

# creating the box

I used the `create_box.sh` from the [vagrant-libvirt
repository](https://github.com/vagrant-libvirt/vagrant-libvirt).

Create the `Vagrantfile` with at least these two lines and any other
config you wish:

    Vagrant.configure("2") do |config|
        config.vm.synced_folder ".", "/vagrant", disabled: true
    end

Creating the box:

    $ create_box.sh debian12.qcow2 debian12.box Vagrantfile
    {128}
    ==> Creating box, tarring and gzipping
    ./metadata.json
    ./Vagrantfile
    ./box.img
    Total de bytes escritos: 2800097280 (2,7GiB, 31MiB/s)
    ==> debian12.box created
    ==> You can now add the box:
    ==>   'vagrant box add debian12.box --name debian12'

Adding the box to Vagrant:

    $ vagrant box add debian12.box --name debian12

# running the new machine

    $ vagrant init debian12
    $ vagrant up

create_box.sh bug in IMG_SIZE: [https://github.com/vagrant-libvirt/vagrant-libvirt/issues/1746](https://github.com/vagrant-libvirt/vagrant-libvirt/issues/1746)
