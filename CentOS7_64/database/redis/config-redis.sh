#!/bin/bash

# version:      1.0
# state:        finish
# updateTime:   2023年5月17日17:36:34

### [配置]--------------------------------------------------------------------

mkdir /opt/redis/data

# 后台启动
# daemonize yes
sed -i 's/daemonize no/daemonize yes/' /usr/local/bin/redis.conf

# 关闭保护模式
# protected-mode no
sed -i 's/protected-mode yes/protected-mode no/' /usr/local/bin/redis.conf

# 固定rdb文件生成位置，需要注意的是，这个目录要事先创建
# dir /opt/redis/data/
sed -i 's/dir .\//dir \/opt\/redis\/data/' /usr/local/bin/redis.conf



# 配置密码,之后登录需要进行身份验证 如：redis-cli -a 123465
# requirepass 123456


### [开机自启动]--------------------------------------------------------------

# 拷贝启动脚本
#cp /opt/redis/redis-6.2.6/utils/redis_init_script  /etc/init.d/redis
#
## 修改启动脚本
#vim /etc/init.d/redis
#
## 修改启动使用配置
#CONF="/usr/local/bin/redis.conf"
sed -i 's/^CONF=".*"/CONF="\/usr\/local\/bin\/redis.conf/' /etc/init.d/redis

## 添加到启动配置中
chkconfig --add redis

## 查看
chkconfig --list

## 重启生效
echo 'Please restart it to take effect'


