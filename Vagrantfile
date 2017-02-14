# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "arch-amd64-virtualbox"
  config.vm.box_url = "https://boxes.bbqnetwork.be/arch-amd64-virtualbox"
  config.ssh.insert_key = false
  # config.vm.box_check_update = false
  config.vm.synced_folder "puppet/manifests", "/etc/puppetlabs/code/environments/vagrant/manifests"
  config.vm.synced_folder "puppet/modules", "/etc/puppetlabs/code/environments/vagrant/modules"
  config.vm.synced_folder "puppet/hiera", "/etc/puppetlabs/puppet"

  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    vb.memory = "4096"
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    vb.customize ["modifyvm", :id, "--nictype2", "virtio"]
    # vboxmanage createmedium disk --filename /tmp/lvm_1.vdi --size 1024
  end

  config.vm.provision "puppet" do |puppet|
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
    node.vm.network "forwarded_port", guest: 80, host: 1080
    config.vm.synced_folder "files/base", "/home/vagrant/base"
    config.vm.provider "virtualbox" do |vb|
      #vb.customize ['createhd', '--filename', 'disk1', '--size', 1 * 10240]
      #vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", 'disk1.vdi']
    end
  end

  config.vm.define "vps" do |node|
    node.vm.hostname = "vps"
    node.vm.network "private_network", ip: "10.10.30.10"
    node.vm.network "forwarded_port", guest: 80, host: 3080
    node.vm.network "forwarded_port", guest: 443, host: 3080
    config.vm.synced_folder "files/vps", "/home/vagrant/vps"
  end

  config.vm.define "lamp" do |node|
    node.vm.hostname = "lamp"
    node.vm.network "private_network", ip: "10.10.20.13"
    node.vm.network "forwarded_port", guest: 80, host: 20108
    node.vm.network "forwarded_port", guest: 443, host: 20104
    config.vm.synced_folder "files/lamp", "/home/vagrant/lamp"
  end

  config.vm.define "workstation" do |node|
    node.vm.hostname = "workstation"
    node.vm.network "private_network", ip: "10.10.20.14"
    config.vm.synced_folder "files/workstation", "/home/vagrant/workstation"
  end

end
