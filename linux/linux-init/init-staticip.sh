#!/bin/bash

#判断是否安装了sed与grep命令
if !command -v sed &> /dev/null || ! command -v grep &> /dev/null
then
	echo "Please install sed and grep!"
	exit
fi

read -p "Please input IP address:" inputIp

if ! echo "${inputIp}" | grep -qE '^([0-9]{1,3}\.){3}[0-9]{1,3}$'
then
	echo "invalid ip address format!"
	exit
fi

prefixIp=$(echo ${inputIp} | cut -d"." -f1-3)

sed -i 's/BOOTPROTO="dhcp"/BOOTPROTO="static"/' /etc/sysconfig/network-scripts/ifcfg-ens33
sed -i "$a\IPADDR="${inputIp}"" /etc/sysconfig/network-scripts/ifcfg-ens33
sed -i "$a\GATEWAY="${inputIp}.2"" /etc/sysconfig/network-scripts/ifcfg-ens33
sed -i "$a\DNS1="${inputIp}.2"" /etc/sysconfig/network-scripts/ifcfg-ens33

systemctl restart network.service

echo "ifcfg-ens33 has been modified successfully."

reboot