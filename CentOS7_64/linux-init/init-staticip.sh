#!/bin/bash

# version:      1.0
# state:        finish
# updateTime:   2023年5月17日17:36:34

### [判断是否安装了sed与grep命令]

if !command -v sed &> /dev/null || ! command -v grep &> /dev/null
then
	echo "Please install sed and grep!"
	exit
fi

### [输入新ip地址]

read -p "Please input IP address:" inputIp

if ! echo "${inputIp}" | grep -qE '^([0-9]{1,3}\.){3}[0-9]{1,3}$'
then
	echo "invalid ip address format!"
	exit
fi

### [更改ifcfg-ens33文件]

prefixIp=$(echo ${inputIp} | cut -d"." -f1-3)
targetFile="/etc/sysconfig/network-scripts/ifcfg-ens33"

sed -i 's/BOOTPROTO="dhcp"/BOOTPROTO="static"/' $targetFile
sed -i "$a IPADDR="$inputIp"" $targetFile
sed -i "$a GATEWAY="$prefixIp.2"" $targetFile
sed -i "$a DNS1="$prefixIp.2"" $targetFile

systemctl restart network.service

echo "ifcfg-ens33 has been modified successfully."

reboot