# -*- mode: ruby -*-
# vi: set ft=ruby :

##################################
##                              ##
## GMdotnet Vagrant LAMP Stack  ##
## Version 1.1.3                ##
##                              ##
##################################

# Import configuration
require 'yaml'
vagrantconfig = YAML.load_file('config/config.yaml')

Vagrant.configure("2") do |config|

  vagrantconfig['gmdotnet'].each do |machine|

    config.vm.define machine['host']['vagrantbox_name'] do |vmhost|
        # Machine info
        vmhost.vm.box = machine['host']['box']['name']
        if machine['host']['box']['version'] != nil
            vmhost.vm.box_version = machine['host']['box']['version']
        end
        vmhost.vm.box_check_update = machine['host']['box']['check_update']
        vmhost.vm.hostname = machine['host']['hostname']
        if machine['host']['hostsupdate']['aliases'] != nil
            vmhost.hostsupdater.aliases = machine['host']['hostsupdate']['aliases']
        end

        # Hostsupdater plugin
        if machine['host']['hostsupdate']['permanent'] == true
          vmhost.hostsupdater.remove_on_suspend = false
        end

        enable_hostupdate = true
        if machine['host']['hostsupdate']['enable'] == false
          enable_hostupdate = "skip"
        end

        ## Private IP Network
        vmhost.vm.network "private_network", ip: machine['host']['private_ip'], hostsupdater: enable_hostupdate

        ## Shared folders
        if machine['host']['share'] != nil
          machine['host']['share'].each do |share|
            vmhost.vm.synced_folder share['folder']['host_folder'], share['folder']['vagrant_folder'], create: true, owner: "vagrant"
          end
        end

        ## Rsync folders
        if machine['host']['rsync'] != nil
          machine['host']['rsync'].each do |rsync|
              rsyncoptions = []
              rsync['folder']['options'].each do |options|
                rsyncoptions.push(options)
              end
              vmhost.vm.synced_folder rsync['folder']['host_folder'], rsync['folder']['vagrant_folder'], type: "rsync", rsync__args: rsyncoptions
          end
        end

        ## Virtualbox options
        vmhost.vm.provider "virtualbox" do |vb|
          # RAM
          vb.memory = machine['host']['ram']
        end

        ## Shell provision
        if machine['host']['provision']['script'] == true
            vmhost.vm.provision "shell", path: "script/backup_database.sh"
        end

        ## Ansible provision
        if machine['host']['provision']['ansible'] == true
            vmhost.vm.provision "ansible_local" do |ansible|
              ansible.verbose = "vv"
              ansible.playbook = "ansible/playbook.yml"
            end
        end
    end

  end

end