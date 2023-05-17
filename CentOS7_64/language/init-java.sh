#!/bin/bash

# 定义安装目录
install_dir="/usr/local/java"

# 创建安装目录
sudo mkdir -p $install_dir

# 下载OpenJDK 8安装包
sudo yum install -y java-1.8.0-openjdk-devel

# 设置环境变量
sudo tee /etc/profile.d/java.sh <<EOF
export JAVA_HOME=$install_dir
export PATH=\$PATH:\$JAVA_HOME/bin
EOF

# 刷新环境变量
source /etc/profile.d/java.sh

# 验证安装结果
java -version

echo " "
echo " "
echo " "

echo "安装版本: 1.8.0   安装目录: /usr/local/java"
