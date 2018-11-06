title: Running OpenBSD on Vultr, check your clock!
category: blog
tags: comp
date: 2018-11-06 16:40
modified: 2018-11-06 16:40

Recently I noticed a problem with the clock on my OpenBSD virtual machine
running on Vultr. The clock on the virtual machine was off by days frequently.
Investigating the problem, I noticed that `top` was not updating the
information each 5s as it should and `sleep 1` was taking more than 1s to run.

After some research, Google lead me to this [Reddit
post](https://www.reddit.com/r/openbsd/comments/7yg56t/have_openbsd_in_vultr_check_your_clock/).

The problem is related with some configuration on the virtualization software
Vultr uses. After calling the support, they fixed it for me **very fast**!

As I'm a n00b, **it was my fault**... I decided to install my virtual machine
as a custom OS using an uploaded image of OpenBSD while Vultr provides an
OpenBSD virtual machine wich runs without this problem as described by their
support "deploying with one of our images from the Vultr control panel would
automatically apply the necessary adjustments".
