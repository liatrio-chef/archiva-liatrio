# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "pozgo/centos7"

   config.vm.network "forwarded_port", guest: 8080, host: 18081

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--cpus", 2]
    v.customize ["modifyvm", :id, "--memory", "1024"]
    #v.customize ["modifyvm", :id, "--name", "archiva"]
  end

  config.berkshelf.enabled = true

  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "archiva-liatrio"
    chef.json = {
    }
  end

  config.vm.provision "shell", inline: "firewall-cmd --permanent --add-port=8080/tcp && firewall-cmd --reload"

end
