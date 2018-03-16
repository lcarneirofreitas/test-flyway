#!/bin/bash

# update locale server
sudo locale-gen pt_BR.UTF-8 && \

# Download and install flyway packages
cd /opt && \
wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/5.0.7/flyway-commandline-5.0.7-linux-x64.tar.gz && \
tar -xvzf *.tar.gz && \
ln -s /opt/flyway-5.0.7/flyway /usr/sbin/flyway
flyway && \

# Install mysql server to tests
export DEBIAN_FRONTEND=noninteractive && \
apt-get -q -y install mysql-server && \
echo 'show databases;' | mysql -uroot && \

# Copy script migration database mysql
cp /vagrant/sql/*.sql /opt/flyway-5.0.7/sql/ && \

# Change root password mysql
echo "update user set authentication_string=PASSWORD('root') where User='root';" | mysql -uroot mysql && \
echo "update user set plugin='mysql_native_password';" | mysql -uroot mysql && \
echo "flush privileges" | mysql -uroot mysql && \
echo "create database teramanagement" | mysql -uroot -proot && \

# Migrate database mysql db teramanagement 
sudo flyway -user=root -password=root -url=jdbc:mysql://localhost:3306/teramanagement migrate && \
sudo flyway -user=root -password=root -url=jdbc:mysql://localhost:3306/teramanagement info && \

# finish
echo "OK"
