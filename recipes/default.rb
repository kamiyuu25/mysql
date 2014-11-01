#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

item = Chef::EncryptedDataBagItem.load('passwords', 'mysql')

%w{mysql-server}.each do |pkg|
  package pkg do
    action :install
  end
end

service "mysqld" do
  action [:enable, :start]
end

execute "set root password" do
  command "mysqladmin -u root password '#{item["pass"]}'"
  only_if "mysql -u root -e 'show databases;'"
end
