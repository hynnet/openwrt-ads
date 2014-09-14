#!/bin/sh
# install-adblock.sh by hynnet
# download and install command:
# curl -k 'https://raw.githubusercontent.com/hynnet/openwrt-ads/master/install-adblock.sh -o /tmp/install-adblock.sh ; chmod +x /tmp/install-adblock.sh ; /tmp/install-adblock.sh

curl -k 'https://raw.githubusercontent.com/hynnet/openwrt-ads/master/dnsmasq.ads' -o /etc/dnsmasq.ads
grep conf-file /etc/dnsmasq.conf || echo -e "\nconf-file=/etc/dnsmasq.ads" >> /etc/dnsmasq.conf
/etc/init.d/dnsmasq restart

