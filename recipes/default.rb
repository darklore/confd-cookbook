#
# Cookbook Name:: confd
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

install_arch = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : '386'
install_version = [node['confd']['version'], node['os'], install_arch].join('_')
install_checksum = node['confd']['checksums'].fetch(install_version)

remote_file File.join(node['confd']['install_dir'], 'confd') do
  source "https://github.com/kelseyhightower/confd/releases/download/v#{node['confd']['version']}/confd-#{node['confd']['version']}-linux-amd64"
  checksum install_checksum
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

[node['confd']['resource_config_dir'], node['confd']['template_dir']].each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    recursive true
  end
end

template "#{node['confd']['config_dir']}/confd.toml" do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
    :backend => node['confd']['backend'],
    :confdir => node['confd']['config_dir'],
    :nodes => node['confd']['nodes'],
  )
end
