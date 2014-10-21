# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "chef/ubuntu-14.04"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.provision "chef_solo" do |chef|
    chef.log_level = :debug
    chef.add_recipe "confd"
    # You may also specify custom JSON attributes:
    chef.json = {}
  end
end
