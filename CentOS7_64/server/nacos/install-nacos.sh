#!/bin/bash

# version:      1.0
# state:        finish
# updateTime:   2023年5月18日17:38:43

echo "Make sure you have mysql and jdk8+ installed!"

mkdir /opt/nacos

cd /opt/nacos

### [下载nacos-2.1.0]
wget https://github.com/alibaba/nacos/releases/download/2.1.0/nacos-server-2.1.0.tar.gz

tar -zxvf nacos-server-2.1.0.tar.gz

### [输入 MySQL 用户名和密码]
read -p "MySQL Username: " username
read -s -p "MySQL Password: " password
echo

### 进入 MySQL 并创建数据库
mysql -u "$username" -p"$password" <<EOF
CREATE DATABASE nacos;
use nacos;
source /opt/nacos/conf/nacos-mysql.sql;
EOF

### [解除防火墙限制]
firewall-cmd --permanent --add-port=8848/tcp

### [启动]
echo 'If you need to start the need to install jdk8 and version, and enter the /opt/nacos/nacos/bin/startup.sh -m standalone command'
# /opt/nacos/nacos/bin/startup.sh -m standalone


## http://自己IP:8848/nacos/index.html

