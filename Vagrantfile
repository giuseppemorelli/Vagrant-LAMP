# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
vagrantconfig = YAML.load_file('config/config.yaml')

Vagrant.configure("2") do |config|

  config.vm.box = "giuseppemorelli/lamp-stack"
  config.vm.box_version = "1.0.1"
  config.vm.hostname = vagrantconfig['hostname']
  config.vm.define vagrantconfig['vagrantbox_name'] do |gmdev|
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: vagrantconfig['private_ip']

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  vagrantconfig['share'].each do |share|
    config.vm.synced_folder share['folder']['host_folder'], share['folder']['vagrant_folder'], create: true, owner: "vagrant"
  end

  vagrantconfig['rsync'].each do |rsync|
      config.vm.synced_folder rsync['folder']['host_folder'], rsync['folder']['vagrant_folder'], type: "rsync"
  end

  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = vagrantconfig['ram']
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  config.vm.provision "shell", path: "script/backup_database.sh"
end
