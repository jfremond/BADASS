# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.define "badass" do |badass|
    badass.vm.hostname = "badass"
    badass.vm.provider "virtualbox" do |v|
      v.name = "BADASS"
      v.memory = 2048
      v.cpus = 2
      v.gui = true
    end
      badass.vm.provision "shell", path: "scripts/install_tools.sh"
    end
end
