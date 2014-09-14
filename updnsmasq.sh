#!/bin/sh
# updnsmasq.sh

curl -k 'https://raw.githubusercontent.com/hynnet/openwrt-ads/master/adblock-lazy.txt' | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/127\.0\.0\.1:' > /tmp/dnsmasq.ads.1
curl -k 'https://easylist-downloads.adblockplus.org/chinalist+easylist.txt' | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/127\.0\.0\.1:' > /tmp/dnsmasq.ads.2
# 合并数据
cat /tmp/dnsmasq.ads.1 >> /tmp/dnsmasq.ads.2
cp /etc/dnsmasq.ads /tmp/storage/mmcblk0p2/conf-bak/dnsmasq-`date +%Y%m%d%H%M%S`.ads
# 排序、合并重复数据
sort -k2n /tmp/dnsmasq.ads.2 | uniq  > /etc/dnsmasq.ads
mkdir /tmp/storage/mmcblk0p2/conf-bak
cp /etc/dnsmasq.conf /tmp/storage/mmcblk0p2/conf-bak/dnsmasq-`date +%Y%m%d%H%M%S`.conf
grep conf-file /etc/dnsmasq.conf || echo -e "\nconf-file=/etc/dnsmasq.ads" >> /etc/dnsmasq.conf
/etc/init.d/dnsmasq restart

