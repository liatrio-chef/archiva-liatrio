# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "liatrio/centos7chefjava"

   config.vm.network "forwarded_port", guest: 8081, host: 18081

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--cpus", 2]
    v.customize ["modifyvm", :id, "--memory", "1024"]
    #v.customize ["modifyvm", :id, "--name", "archiva"]
  end

  config.berkshelf.enabled = true

  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "archiva-liatrio"
    chef.add_recipe "minitest-handler"
    chef.json = {
        "java" => {
          "jdk_version" => "8",
        },
        "archiva" => {
          "version" => "2.2.0",
          "checksum" => "6af7c3c47c35584f729a9c139675a01f9a9819d0cdde292552fc783284a34cfa",
          #"mirror" => "https://192.168.1.125/",
          "web_port" => "8081",
        }
    }
  end

  config.vm.provision "shell", inline: "firewall-cmd --permanent --add-port=8081/tcp && firewall-cmd --reload"

end
