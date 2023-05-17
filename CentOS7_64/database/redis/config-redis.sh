#!/bin/bash

### [开机自启动]--------------------------------------------------------------

# 拷贝启动脚本
cp /opt/redis/redis-6.2.6/utils/redis_init_script  /etc/init.d/redis

# 修改启动脚本
vim /etc/init.d/redis

# 修改启动使用配置
CONF="/usr/local/bin/redis.conf"

# 添加到启动配置中
chkconfig --add redis

# 查看
chkconfig --list

# 重启生效
reboot


### [配置]--------------------------------------------------------------------

# 后台启动
# daemonize yes
# 关闭保护模式
# protected-mode no
# 固定rdb文件生成位置，需要注意的是，这个目录要事先创建
# dir /opt/redis/data/
# 配置密码,之后登录需要进行身份验证 如：redis-cli -a 123465
# requirepass 123456