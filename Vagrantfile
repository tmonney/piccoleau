# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Setup virtual machine box. This VM configuration code is always executed.
  config.vm.box = "chef/ubuntu-13.10"

  # Web application
  config.vm.network :forwarded_port, :host => 9000, :guest => 9000
  # Livereload
  config.vm.network :forwarded_port, :host => 35729, :guest => 35729

  # Docker configuration needed before install
  config.vm.provision :shell, :path => "install.sh"
end