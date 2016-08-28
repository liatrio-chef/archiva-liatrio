#
# Cookbook Name:: archiva-liatrio
# Recipe:: default
#
#

node.override['java']['jdk_version'] = '8'
#node.override['archiva']['version'] = '2.2.0'

include_recipe "archiva"

cookbook_file '/opt/archiva/conf/security.properties' do
  source 'security.properties'
  owner 'root'
  group 'root'
  mode  '0666'
  action :create
end

ruby_block 'wait_for_archiva' do
  block do
    true until ::File.exists?('/opt/archiva/data/databases')
  end
end

cookbook_file '/opt/archiva/data.tar.gz' do
  source 'data.tar.gz'
  owner 'root'
  group 'root'
  mode '0666'
  action :create
end

service "archiva_stop" do
  service_name "archiva"
  action :stop
  not_if do ::File.exists?('/opt/archiva/data.updated') end
end

template "#{node[:archiva][:home]}/conf/jetty.xml" do
  source   'jetty.xml.erb'
  mode     '0644'
  owner    node[:archiva][:user_owner]
#  notifies :restart, 'service[archiva]', :immediately
end

execute 'remove_databases' do
  command 'rm -rf /opt/archiva/data/'
  not_if do ::File.exists?('/opt/archiva/data.updated') end
end

execute 'untar_data' do
  command 'tar -C /opt/archiva -zxvf /opt/archiva/data.tar.gz'
  not_if do ::File.exists?('/opt/archiva/data.updated') end
end

cookbook_file '/opt/archiva/data.updated' do
  source 'data.updated'
  owner 'root'
  group 'root'
  mode '0666'
  action :create
  notifies :start, "service[archiva]"
end

service "archiva_enable" do
  service_name "archiva"
  action :enable
end
