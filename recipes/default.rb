#
# Cookbook Name:: confd
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

install_arch = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : '386'
install_version = [node['confd']['version'], node['os'], install_arch].join('_')
install_checksum = node['confd']['checksums'].fetch(install_version)

# Install confd
remote_file File.join(node['confd']['install_dir'], 'confd') do
  source "https://github.com/kelseyhightower/confd/releases/download/v#{node['confd']['version']}/confd-#{node['confd']['version']}-linux-amd64"
  checksum install_checksum
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Create directories for configuration files
[node['confd']['resource_dir'], node['confd']['template_dir']].each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    recursive true
  end
end

config_file = "#{node['confd']['config_dir']}/confd.toml"

template config_file do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
   :backend => node['confd']['backend'],
   :client_cakeys => node['confd']['client_cakeys'],
   :client_cert => node['confd']['client_cert'],
   :client_key => node['confd']['client_key'],
   :confdir => node['confd']['config_dir'],
   :debug => node['confd']['debug'],
   :interval => node['confd']['interval'],
   :nodes => node['confd']['nodes'],
   :noop => node['confd']['noop'],
   :prefix => node['confd']['prefix'],
   :quiet => node['confd']['quiet'],
   :scheme => node['confd']['scheme'],
   :srv_domain => node['confd']['srv_domain'],
   :verbose => node['confd']['verbose'],
   :watch => node['confd']['watch']
  )
end

# Install init.d script
template '/etc/init.d/confd' do
  source 'confd-init.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    confd_binary: "#{node['confd']['install_dir']}/confd",
    config_file: config_file
  )
end

service 'confd' do
  supports status: true, restart: true
  action [:enable, :start]
  subscribes :restart, "template[#{config_file}]", :delayed
end
