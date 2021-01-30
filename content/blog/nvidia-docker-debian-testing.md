title: NVIDIA docker images on Debian Bullseye workaround
tags: comp
category: blog
date: 2021-01-30 19:44
modified: 2021-01-30 19:44

Until the problem is fixed, use the workaround below.

Edit the file `/etc/nvidia-container-runtime/config.toml` and set

    no-cgroups = true  
    ldconfig = "/usr/sbin/ldconfig.real"

Running a container:

    docker run --gpus all -it --rm \
        --device /dev/nvidia0:/dev/nvidia0 \
        --device /dev/nvidiactl:/dev/nvidiactl \
        --device /dev/nvidia-modeset:/dev/nvidia-modeset \
        --device /dev/nvidia-uvm:/dev/nvidia-uvm \
        --device /dev/nvidia-uvm-tools:/dev/nvidia-uvm-tools \
        nvcr.io/nvidia/tensorflow:20.12-tf1-py3

to test, run `nvidia-smi` on the container.


source:  
[https://github.com/NVIDIA/nvidia-docker/issues/1447#issuecomment-757034464](https://github.com/NVIDIA/nvidia-docker/issues/1447#issuecomment-757034464)
