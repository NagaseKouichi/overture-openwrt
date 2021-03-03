#!/bin/sh -e
set -o pipefail

ipfilename=`uci get overture.@overture[0].IPNetworkFilePrimary`

wget https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt -O /tmp/ip_network_primary.tmp
mv -f /tmp/ip_network_primary.tmp $ipfilename

/etc/init.d/overture restart