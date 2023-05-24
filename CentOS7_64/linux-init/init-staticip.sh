#!/bin/bash

# version:      1.2.1
# state:        finish
# updateTime:   2023年5月24日23:37:30
# description:  获取用户输入ip地址并更改本机ip为静态ip

### [判断是否安装了sed与grep命令]

if ! /usr/bin/command -v sed &> /dev/null || ! /usr/bin/command -v grep &> /dev/null
then
        echo "Please install sed and grep!"
        exit
fi

### [输入新ip地址]

read -p "Please input IP address: " inputIp

if ! echo "${inputIp}" | grep -qE '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'
then
        echo "Invalid IP address format!"
        exit
fi

### [获取本机IP地址]

currentIp=$(hostname -I | awk '{print $1}')
currentPrefixIp=$(echo "${currentIp}" | cut -d"." -f1-3)
inputPrefixIp=$(echo "${inputIp}" | cut -d"." -f1-3)

### [判断IP地址是否在同一个局域网下]

if [ "${currentPrefixIp}" != "${inputPrefixIp}" ]; then
    echo "Error: The input IP address is not in the same LAN as the current machine."
    exit
fi

### [更改ifcfg-ens33文件]

targetFile="/etc/sysconfig/network-scripts/ifcfg-ens33"

sed -i 's/^BOOTPROTO=".*"/BOOTPROTO="static"/' "${targetFile}"

# 判断文件中是否已存在IP地址相关配置
if grep -qE '^(IPADDR|GATEWAY|DNS1)="' "${targetFile}"
then
    # 替换已存在的IP地址相关配置
    sed -i 's/^IPADDR=".*"/IPADDR="'${inputIp}'"/' "${targetFile}"
    sed -i 's/^GATEWAY=".*"/GATEWAY="'${inputPrefixIp}.2'"/' "${targetFile}"
    sed -i 's/^DNS1=".*"/DNS1="'${inputPrefixIp}.2'"/' "${targetFile}"
else
    # 追加新的IP地址相关配置
    sed -i "/BOOTPROTO/a IPADDR=\"${inputIp}\"" "${targetFile}"
    sed -i "/IPADDR/a GATEWAY=\"${inputPrefixIp}.2\"" "${targetFile}"
    sed -i "/GATEWAY/a DNS1=\"${inputPrefixIp}.2\"" "${targetFile}"
fi

echo "The new IP address is ${inputIp}"
echo
echo "ifcfg-ens33 has been modified successfully."
echo
echo "Run the [systemctl restart network.service] command to restart the network service"