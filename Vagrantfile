# -*- mode: ruby -*-
# vi: set ft=ruby :

##################################
##                              ##
## GMdotnet Vagrant LAMP Stack  ##
## Version 1.0.5                ##
##                              ##
###################################

# Import configuration
require 'yaml'
vagrantconfig = YAML.load_file('config/config.yaml')

Vagrant.configure("2") do |config|

  ## Box configuration
  config.vm.box = "giuseppemorelli/lamp-stack"
  config.vm.box_version = "1.0.1"
  config.vm.hostname = vagrantconfig['hostname']
  config.vm.define vagrantconfig['vagrantbox_name'] do |gmdev|
  end

  ## Forwarded port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  ## Private IP Network
  config.vm.network "private_network", ip: vagrantconfig['private_ip']

  ## Public IP Netowork
  # config.vm.network "public_network"

  ## Shared folders
  if vagrantconfig['share'] != nil
    vagrantconfig['share'].each do |share|
      config.vm.synced_folder share['folder']['host_folder'], share['folder']['vagrant_folder'], create: true, owner: "vagrant"
    end
  end

  ## Rsync folders
  if vagrantconfig['rsync'] != nil
    vagrantconfig['rsync'].each do |rsync|
        rsyncoptions = []
        rsync['folder']['options'].each do |options|
          rsyncoptions.push(options)
        end
        config.vm.synced_folder rsync['folder']['host_folder'], rsync['folder']['vagrant_folder'], type: "rsync", rsync__args: rsyncoptions
    end
  end

  ## Virtualbox options
  config.vm.provider "virtualbox" do |vb|
    # RAM
    vb.memory = vagrantconfig['ram']
  end

  ## Shell provision
  config.vm.provision "shell", path: "script/backup_database.sh"

  ## Ansible provision
  #config.vm.provision "ansible_local" do |ansible|
  #  ansible.playbook = "ansible/playbook.yml"
  #end
end
