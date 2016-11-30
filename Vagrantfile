# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "arch-amd64-virtualbox"
  config.ssh.insert_key = false
  # config.vm.box_check_update = false
  config.vm.synced_folder "puppet/manifests", "/etc/puppetlabs/code/environments/vagrant/manifests"
  config.vm.synced_folder "puppet/modules", "/etc/puppetlabs/code/environments/vagrant/modules"
  config.vm.synced_folder "puppet/hiera", "/etc/puppetlabs/puppet"

  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end

  config.vm.provision "puppet" do |puppet|
    #puppet.hiera_config_path = "puppet/hiera/hiera.yaml"
    #puppet.manifest_file = ""
    #puppet.manifests_path = ["vms", "puppet/manifests/"]
    #puppet.module_path = "puppet/modules"
    #puppet.options = "--environment 'vagrant'"
    puppet.environment = "vagrant"
    puppet.environment_path = ["vm", "/etc/puppetlabs/code/environments"]
    #puppet.options = "--debug"
    puppet.environment = "vagrant"
  end

  # Node port forwarding:
  # Use the last 2 cypers of the ip addr and then the port number
  config.vm.define "base" do |node|
    node.vm.hostname = "base"
    node.vm.network "private_network", ip: "10.10.20.10"
    config.vm.synced_folder "files/base", "/home/vagrant/base"
    node.vm.network "forwarded_port", guest: 7272, host: 7272
  end

  config.vm.define "vps" do |node|
    node.vm.hostname = "vps"
    node.vm.network "private_network", ip: "10.10.30.10"
    node.vm.network "forwarded_port", guest: 80, host: 3080
    node.vm.network "forwarded_port", guest: 443, host: 3080
  end

  config.vm.define "hornetmq" do |node|
    node.vm.hostname = "hornetmq"
    node.vm.network "private_network", ip: "10.10.20.12"
    node.vm.network "forwarded_port", guest: 80, host: 20128
    node.vm.network "forwarded_port", guest: 443, host: 20124
    config.vm.synced_folder "files/hornetmq", "/home/vagrant/hornetmq"
  end

  config.vm.define "lamp" do |node|
    node.vm.hostname = "lamp"
    node.vm.network "private_network", ip: "10.10.20.13"
    node.vm.network "forwarded_port", guest: 80, host: 20108
    node.vm.network "forwarded_port", guest: 443, host: 20104
    config.vm.synced_folder "files/lamp", "/home/vagrant/lamp"
  end

end
