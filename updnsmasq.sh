#!/bin/sh
# updnsmasq.sh

curl -k 'https://raw.githubusercontent.com/hynnet/openwrt-ads/master/adblock-lazy.txt' | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/127\.0\.0\.1:' > /etc/dnsmasq.ads
mkdir /tmp/storage/mmcblk0p2/conf-bak
cp /etc/dnsmasq.conf /tmp/storage/mmcblk0p2/conf-bak/dnsmasq-`date +%Y%m%d%H%M%S`.conf
grep conf-file /etc/dnsmasq.conf || echo -e "\nconf-file=/etc/dnsmasq.ads" >> /etc/dnsmasq.conf
/etc/init.d/dnsmasq restart

