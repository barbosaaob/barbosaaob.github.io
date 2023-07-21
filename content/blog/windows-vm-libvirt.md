title: Creating a Windows VM on Libvirt with NixOS and PCI (GPU) passthrough
tags: comp
category: blog
date: 2023-06-23 17:08
modified: 2023-06-23 17:08
status: draft

# list iommu groups

  #!/bin/bash
  shopt -s nullglob
  for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
      echo "IOMMU Group ${g##*/}:"
      for d in $g/devices/*; do
          echo -e "\t$(lspci -nns ${d##*/})"
      done;
  done;

Output:

  ...
  IOMMU Group 10:
    	01:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU116 [GeForce GTX 1660 SUPER] [10de:21c4] (rev a1)
    	01:00.1 Audio device [0403]: NVIDIA Corporation TU116 High Definition Audio Controller [10de:1aeb] (rev a1)
    	01:00.2 USB controller [0c03]: NVIDIA Corporation TU116 USB 3.1 Host Controller [10de:1aec] (rev a1)
    	01:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU116 USB Type-C UCSI Controller [10de:1aed] (rev a1)
  ...

# NixOS configuration

  # PCI Passthrough
  boot.kernelParams = [ "amd_iommu=on" "vfio-pci.ids=10de:21c4,10de:1aeb,10de:1aec,10de:1aed" ];
  boot.kernelModules = [ "kvm-amd" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
  boot.extraModprobeConfig = ''
    options vfio-pci ids=10de:21c4,10de:1aeb,10de:1aec,10de:1aed
    softdep nvidia pre: vfio-pci
  '';
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 adriano qemu-libvirtd -"
  ];

  # Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Add user to group libvirtd
  users.users.adriano = {
    isNormalUser = true;
    description = "Adriano";
    extraGroups = [ "libvirtd" ... ];
    packages = with pkgs; [
      ...
      pciutils
      virt-manager
      ...
    ];
  };

  # Libvirt
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
      verbatimConfig = ''
        nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
      '';
    };
  };

# creating the vm

- Change chipset to Q35
- Set UEFI (OVMF_CODE.fd/OVMF_CODE_secboot.fd)
- Add TPM device (TIS 2.0)
- Set CPU topology (Ex.: 8 vCPUs -> socket=1, cores=4, threads=2) with
  host-passthrough
- Change disk to VirtIO (need driver during install)
- Change network to VirtIO
- Add **ALL** PCI devices on the GPU group
- Add a Spice graphics if you wish to use Looking Glass

Dont't know why I could not boot without a video device other than the PCI
GPU (was supposed abble to). Just add a VirtIO video device and turn it off
on Windows.

# Looking Glass

  $ looking-glass-client -f /dev/shm/looking-glass

# resources

https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF

https://gist.github.com/techhazard/1be07805081a4d7a51c527e452b87b26

https://www.youtube.com/watch?v=IDnabc3DjYY

https://youtu.be/KVDUs019IB8?t=561
