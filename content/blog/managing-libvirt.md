title: Managing VMs on libvirt
tags: comp
category: blog
date: 2021-01-30 19:29
modified: 2021-01-30 19:29

# install libvirt

    # apt-get install libvirt-daemon-system qemu-system

if you wish a GUI manager:

    # apt-get install virt-manager

if you wish a CLI manager:

    # apt-get install libvirt-clients virtinst

# add user to libvirt group
If you wish to use libvirt as a regular user, you need to add the user to
libvirt group:

    # usermod -aG libvirt USER

you need to relog after this.

# managing vms
The commands below need `libvirt-clients` package:

- list all vms:

    `# virsh list --all`

- start vm:

    `# virsh start VM`

- stop vm:

    `# virsh shutdown VM`

- force stop vm:

    `# virsh destroy VM`

- delete vm:

    `# virsh undefine VM`  
    `# virsh undefine --remove-all-storage VM`

- list all networks:

    `# virsh net-list --all`

- start a bridge network:

    `# virsh net-start NETWORK`

- stop a bridge network:

    `# virsh net-destroy NETWORK`

- list ip of vms connected to the default bridge network:

    `# virsh net-dhcp-leases default`

# clone and reset vm

    # virt-clone --original ORIGINAL_VM --name NEW_VM --auto-clone

`--auto-clone` uses the same vm settings from ORIGINAL_VM on NEW_VM.

    # virt-sysprep -d NEW_VM --root-password password:NEW_PASSWORD \
          --hostname HOSTNAME --ssh-inject USER:file:PATH_TO_SSH_PUB_KEY \
          --firstboot-command "dpkg-reconfigure openssh-server" \
          --firstboot init-config.sh

`--root-password` defines root password  
`--hostname` defines vm hostname  
`--ssh-inject` copy ssh public key to USER `.ssh/authorized_keys` file  
`--firstboot-command` executes a command on the first boot (reconfiguring openssh is necessary as `virt-sysprep` deletes ssh keys)  
`--firstboot init-config.sh` runs the script `init-config.sh` on first boot

# tuning
Use `virsh edit VM` and the lines below after the line `<vcpu ...`

    <cputune>
      <vcpupin vcpu='0' cpuset='0'/>
      <vcpupin vcpu='1' cpuset='4'/>
      <vcpupin vcpu='2' cpuset='1'/>
      <vcpupin vcpu='3' cpuset='5'/>
    </cputune>

source:  
[https://wiki.debian.org/KVM](https://wiki.debian.org/KVM)  
[https://www.cyberciti.biz/faq/reset-a-kvm-clone-virtual-machines-with-virt-sysprep-on-linux/](https://www.cyberciti.biz/faq/reset-a-kvm-clone-virtual-machines-with-virt-sysprep-on-linux/)
