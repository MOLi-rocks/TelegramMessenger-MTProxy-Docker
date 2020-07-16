#!/bin/sh
intWORKER=${WORKER:-1}
strSECRET=${SECRET:-$(head -c 16 /dev/urandom | xxd -ps)}

/mtproto-proxy-config/mtproxy-config-updater.sh

# Start mtproto-proxy
/usr/bin/mtproto-proxy -u nobody -p 8888 -H 443 -S "$strSECRET" --aes-pwd /mtproto-proxy-config/proxy-secret /mtproto-proxy-config/proxy-multi.conf -M "$intWORKER"
