title: Creating an self-signed SSL certificate
tags: comp
category: blog
date: 2021-11-12 15:31
modified: 2021-11-12 15:31


    # openssl req -newkey rsa:4096 -sha256 -nodes -x509 \
      -subj "/C=BR/ST=MS/L=Dourados/O=AB\ Labs/CN=adrianobarbosa.xyz" \
      -days 365 -keyout server.key -out server.crt

From the man page:

* _req_ command can create self-signed certificates, for use as root CAs
* _-newkey rsa:4096_ create a new certificate request and a new private RSA key with 4096 bits in size
* _-sha256_ the message digest to sign the request with
* _-nodes_ do not encrypt the private key
* _-x509_ output a self-signed certificate
* _-subj_ the subject field of the request
* _-days_ number of days to certify the certificate for
* _-keyout_ file to write the newly created private key to
* _-out_ output file to write to
