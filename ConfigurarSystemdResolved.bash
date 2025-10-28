#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing systemd-resolved and Network Manager
DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y systemd-resolved network-manager || exit 1

# Enabling systemd-resolved service and network manager service
systemctl enable --now systemd-resolved.service NetworkManager

# Backing up configuration file
cp "/etc/systemd/resolved.conf" "/etc/systemd/resolved.conf.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Generating new configuration file
{
  echo "[Resolve]"
  echo "DNSSEC=allow-downgrade"
  echo "DNSOverTLS=opportunistic"
  echo "DNSStubListener=no"
  echo "Cache=yes"
  echo "#DNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net 2620:fe::fe#dns.quad9.net 2620:fe::9#dns.quad9.net 8.8.8.8#dns.google 8.8.4.4#dns.google 2001:4860:4860::8888#dns.google 2001:4860:4860::8844#dns.google 1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com 2606:4700:4700::1111#cloudflare-dns.com 2606:4700:4700::1001#cloudflare-dns.com 208.67.222.222#doh.opendns.com 208.67.220.220#doh.opendns.com 2620:119:35::35#doh.opendns.com 2620:119:53::53#doh.opendns.com"
} > "/etc/systemd/resolved.conf"

# Restarting systemd-resolved
systemctl restart systemd-resolved.service

# Setting systemd-resolved the default DNS resolver
mv "/etc/resolv.conf" "/etc/resolv.conf.backup.$(date "+%d-%m-%Y_%H:%M:%S")"
ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
