# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.define 'mo_piwik', primary: true do |app|
    app.vm.hostname = "piwik.desarrollo.unlp.edu.ar"
    app.omnibus.chef_version = "11.16.4"
    app.vm.box = "chef/ubuntu-14.04"
    app.vm.network :private_network, ip: "10.100.26.2"
    app.berkshelf.enabled = true
    app.vm.provision :chef_zero do |chef|
      chef.json = {
        mysql: {
          server_root_password: 'rootpass',
        },
        mo_piwik: {
          force_deploy: true
        }
      }
      chef.run_list = [
        "recipe[apt::default]",
        "recipe[mo_application_php::install]",
        "recipe[mo_mysql::standalone-server]",
        "recipe[mo_piwik::database]",
        "recipe[mo_piwik::deploy]",
      ]
    end
  end


end
