title: WireGuard VPN on OpenBSD
tags: comp
category: blog
date: 2022-09-11 20:19
modified: 2022-09-11 20:35

# Install WireGuard tools

    # pkg_add wireguard-tools

For QR code config:

    pkg_add libqrencode

Create a directory to store keys and config files:

    # mkdir /etc/wireguard

# Create server keys

    # cd /etc/wireguard
    # umask 077
    # wg genkey > server-private.key
    # wg pubkey <<EOF > server-public.key
    > server private key goes here
    > EOF

# Configure `wg0`

I'm using `192.168.0.1/24` network.
Create `/etc/hostname.wg0` with the content:

    inet 192.168.0.1 255.255.255.0
    !/usr/local/bin/wg setconf wg0 /etc/wireguard/server.conf

# Setup pf

Add the lines below in `/etc/pf.conf`

    pass out quick on egress from wg0:network nat-to (egress)

Reload `pf` rules:

    # pfctl -f /etc/pf.conf

# Enable IP forwarding

    # sysctl net.inet.ip.forwarding=1

Make it persistent:

    # echo 'net.inet.ip.forwarding=1' >> /etc/sysctl.conf

# Creating client and server config file

Creating client keys:

    # cd /etc/wireguard
    # umask 077
    # wg genkey > client1-private.key
    # wg pubkey <<EOF > client1-public.key
    > client1 private key goes here
    > EOF

These files can be deleted after we use.

Create the `client1.conf` config file with the content:

    [Interface]
    PrivateKey = client1 private key goed here
    Address = 192.168.0.2/32
    DNS = 8.8.8.8

    [Peer]
    PublicKey = server public key goes here
    AllowedIPs = 0.0.0.0/0
    Endpoint = server public address:51820

Create the file `/etc/wireguard/server.conf` with the content

    [Interface]
    PrivateKey = server private key goes here
    ListenPort = 51820

    [Peer]
    PublicKey = client 1 public key goes here
    AllowedIPs = 192.168.0.2/32

    [Peer]
    PublicKey = client 2 public key goes here
    AllowedIPs = 192.168.0.3/32

# Start `wg0` interface

    # sh /etc/netstart wg0

Check:

    # wg
    interface: wg0
    public key: SERVERPUBKEY
    private key: (hidden)
    listening port: 51820

    peer: CLIENT1PUBKEY
    allowed ips: 192.168.0.2/32

# Configure Android and iOS clients

On server:

    # qrencode -t ansiutf8 < client1.conf

Scan the QR code using WireGuard app on your mobile device.

# Configure Linux client

Rename `client1.conf` to `wg0.conf`

    # nmcli connection import type wireguard file wg0.conf

or use `nm-connection-editor` and create a WireGuard virtual connection with
`client1.conf` information.

To start the connection:

    # nmcli connection up wg0

Source:  
[https://thomasward.com/openbsd-wireguard/](https://thomasward.com/openbsd-wireguard/)  
[https://lipidity.com/openbsd/wireguard/](https://lipidity.com/openbsd/wireguard/)  
[https://dataswamp.org/~solene/2021-10-09-openbsd-wireguard-exit.html](https://dataswamp.org/~solene/2021-10-09-openbsd-wireguard-exit.html)
