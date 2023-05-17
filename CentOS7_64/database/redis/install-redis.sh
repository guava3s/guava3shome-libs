#!/bin/bash

# redis网址：
# site: https://redis.io/
#                             _._
#                        _.-``__ ''-._
#                   _.-``    `.  `_.  ''-._           Redis 6.2.6 (00000000/0) 64 bit
#               .-`` .-```.  ```\/    _.,_ ''-._
#              (    '      ,       .-`  | `,    )     Running in standalone mode
#              |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
#              |    `-._   `._    /     _.-'    |     PID: 32377
#               `-._    `-._  `-./  _.-'    _.-'
#              |`-._`-._    `-.__.-'    _.-'_.-'|
#              |    `-._`-._        _.-'_.-'    |           https://redis.io
#               `-._    `-._`-.__.-'_.-'    _.-'
#              |`-._`-._    `-.__.-'    _.-'_.-'|
#              |    `-._`-._        _.-'_.-'    |
#               `-._    `-._`-.__.-'_.-'    _.-'
#                   `-._    `-.__.-'    _.-'
#                       `-._        _.-'
#                           `-.__.-'
#

### [下载与安装]----------------------------------------------------------------


# CentOS7安装gcc依赖
yum install -y gcc tcl

# 进入redis目录 下载redis
mkdir /opt/redis
cd /opt/redis
wget https://download.redis.io/releases/redis-6.2.6.tar.gz

# CentOS7解压缩
tar -zxvf redis-6.2.6.tar.gz

# CentOS7进入redis目录，运行编译命令
cd redis-6.2.6
make
sudo make install

# 默认的安装路径是在 /usr/local/bin目录下，查看目录下的内容确保安装成功
cd /usr/local/bin

# 备份配置文件
cp /opt/redis/redis-6.2.6/redis.conf /usr/local/bin/redis.conf


### [启动]--------------------------------------------------------------------

# 前台启动
# redis-server

# 后台启动，后面是配置文件的位置，可以自由指定，且最好是复制一份不要在原配置文件上改配置
redis-server /usr/local/bin/redis.conf

echo 'Redis started the background, can pass "ps - ef | grep redis" command to view'