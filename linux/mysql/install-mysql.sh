#!/bin/bash

# 检查是否安装了git

if ! command -v git &> /dev/null
then
        echo "Please install git!"
        exit
fi

# 准备卸载mariadb
rpm -qa | grep mariadb
# 卸载mariadb
rpm -e --nodeps mariadb-libs

echo 'mariadb is uninstalled...'

# 开始安装MySQL
echo 'Start installing MySQL...'

# 自动创建/opt/automysql目录
echo 'Automatically create the /opt/automysql directory...'

directory_path="/opt/guava3s_automysql"

if [ -d ${directory_path} ]
then
    	echo "${directory_path} already exist"
	directory_path=/opt/gAuto_${(date "+%Y%m%d%H%M%S")}_mysql
	mkdir ${directory_path}
else
	mkdir ${directory_path}
fi



#进入/opt目录
cd /opt

# 下载MySQL
git clone --branch mysql https://github.com/guava3s/auto-repository-db.git

cp /opt/auto-repository-db/msyql-5.7-client_server/MySQL-client-5.5.54-1.linux2.6.x86_64.rpm ${directory_path}/MySQL-client-5.5.54-1.linux2.6.x86_64.rpm
cp /opt/auto-repository-db/msyql-5.7-client_server/MySQL-server-5.5.54-1.linux2.6.x86_64.rpm ${directory_path}/MySQL-server-5.5.54-1.linux2.6.x86_64.rpm

rm -rfv /opt/auto-repository-db

# 解压MySQL文件
cd ${directory_path}
rpm -ivh MySQL-client-5.5.54-1.linux2.6.x86_64.rpm
rpm -ivh MySQL-server-5.5.54-1.linux2.6.x86_64.rpm

# 启动MySQL服务
service mysql start

# 设置mysql密码
mysqladmin -u root password '123456'

# 将/usr/share/mysql下的my-huge.cnf复制到/etc/my.cnf
cp /usr/share/mysql/my-huge.cnf /etc/my.cnf


# 定义要添加的内容
client="[client]\ndefault-character-set=utf8\n"
mysqld="[mysqld]\ncharacter_set_server=utf8\ncharacter_set_client=utf8\ncollation-server=utf8_general_ci\n"
mysql="[mysql]\ndefault-character-set=utf8\n"

# 修改my.cnf文件
sed -i "/^\[client\]/a\\$client" /etc/my.cnf
sed -i "/^\[mysqld\]/a\\$mysqld" /etc/my.cnf
sed -i "/^\[mysql\]/a\\$mysql" /etc/my.cnf



# 创建可远程访问的root用户并授予所有权限
mysql -uroot -p123456 <<EOF
grant all privileges on *.* to root@'%' identified by '123456';
flush privileges;
exit;
EOF


echo "MySQL installation is completed."