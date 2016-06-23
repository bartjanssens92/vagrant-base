# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "centos-71-x64-vbox"
  config.ssh.insert_key = false
  # config.vm.box_check_update = false
  config.vm.synced_folder "puppet/hiera/data", "/etc/hiera"

  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end

  config.vm.provision "puppet" do |puppet|
    puppet.hiera_config_path = "puppet/hiera/hiera.yaml"
    puppet.manifest_file = ""
    puppet.manifests_path = "puppet/manifests/"
    puppet.module_path = "puppet/modules"
    puppet.options = "--environment 'vagrant'"
  end

  config.vm.define "base" do |node|
    node.vm.hostname = "base"
    node.vm.network "private_network", ip: "100.10.20.10"
  end

  config.vm.define "rundeck" do |node|
    node.vm.hostname = "rundeck.vagranttest.bbqnetwork.be"
    node.vm.network "private_network", ip: "100.10.20.10"
    node.vm.network "forwarded_port", guest: 4440, host: 4440
    node.vm.network "forwarded_port", guest: 4443, host: 4443
  end

end
