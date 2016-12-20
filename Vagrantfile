# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrantfile will spin up Centos with Archiva

Vagrant.configure(2) do |config|
  config.vm.box = 'bento/centos-7.2'

  config.vm.network 'forwarded_port', guest: 8080, host: 18080

  # Configure box specs
  config.vm.provider 'virtualbox' do |v|
    # fix for bento box issue https://github.com/chef/bento/issues/682
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    v.customize ['modifyvm', :id, '--cableconnected1', 'on']
    v.customize ['modifyvm', :id, '--cableconnected2', 'on']
    v.customize ['modifyvm', :id, '--cpus', 2]
    v.customize ['modifyvm', :id, '--memory', '1024']
    # v.customize ["modifyvm", :id, "--name", "archiva"]
  end

  # Provision using chef
  # Installs java first then the liatrio archiva wrapper.
  config.berkshelf.enabled = true
  config.vm.provision 'chef_solo' do |chef|
    chef.version = '12.16.42'

    chef.add_recipe 'java'
    chef.add_recipe 'archiva-liatrio'
    chef.json = {
      'java' => {
        'jdk_version' => '8',
        'install_flavor' => 'openjdk'
      },
      'archiva' => {
        'version' => '2.2.0',
        'checksum' =>
          '6af7c3c47c35584f729a9c139675a01f9a9819d0cdde292552fc783284a34cfa',
        # "mirror" => "https://192.168.1.125/",
        # "web_port" => "8080",
      }
    }
  end
end
