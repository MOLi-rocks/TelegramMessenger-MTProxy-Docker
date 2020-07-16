#!/bin/sh

# Update mtproto-proxy configs
curl -s https://core.telegram.org/getProxySecret -o /mtproto-proxy-config/proxy-secret

curl -s https://core.telegram.org/getProxyConfig -o /mtproto-proxy-config/proxy-multi.conf