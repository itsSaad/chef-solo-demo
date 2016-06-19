#
# Cookbook Name:: mysql_wrapper
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

mysql_service 'default' do
  port '3306'
  version '5.7'
  initial_root_password 'helloworldisgoodithink'
  action [:create, :start]
end
