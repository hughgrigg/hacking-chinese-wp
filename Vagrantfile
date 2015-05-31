# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "hashicorp/precise64"

  config.vm.network "forwarded_port", guest: 80, host: 8888

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "wp-content", "/home/vagrant/sync/wp-content"
  config.vm.synced_folder "vagrant/hc", "/home/vagrant/sync/hc"

  config.vm.provision "shell", privileged: true, path: "vagrant/root-provision.sh"
  config.vm.provision "shell", privileged: false, path: "vagrant/provision.sh"
  config.vm.provision "shell", privileged: true, path: "vagrant/server-provision.sh"
end
