title: Using Let's Encrypt DNS-01 challenge on OpenBSD
category: blog
tags: comp
date: 2019-08-30 09:52
modified: 2019-08-30 09:52

So, my ISP is blocking port 80... I could redirect traffic to my server using another port, but was not able to renew my Let's Encrypt certificates using HTTP-01 challenge. This is how one could use DNS-01 challenge to get/renew certificates.

First install certbot:

    doas pkg_add certbot

Now ask for the challenge:

    certbot certonly --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory --manual-public-ip-logging-ok -d your.domain

Change `your.domain` with yout domain, `adrianobarbosa.xyz` in my case.

Certbot will return:

    Please deploy a DNS TXT record under the name
    _acme-challenge.your.domain with the following value:

    aCMe-cHaLlenGe-vAluE

where `aCMe-cHaLlenGe-vAluE` is a string you will set on your DNS server as a
TXT record value under the name `_acme-challenge`.

Wait for DNS propagation and press Enter.


Source: [DEV](https://dev.to/nabbisen/let-s-encrypt-wildcard-certificate-with-certbot-plo)
