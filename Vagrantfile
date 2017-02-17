# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  
  config.vm.define "server" do |server|
	server.vm.box = "ubuntu/xenial64"
	server.vm.hostname = "server"
	server.vm.network "private_network", ip: "192.168.33.10"
	server.vm.provider "virtualbox" do |vb|
		#vb.gui = true
		vb.memory = "4096"
	end
	server.vm.provision "shell", inline: <<-SHELL
		apt-get update -y
		apt-get install -y python
	SHELL
  end
  
  config.vm.define "honeypot1" do |honeypot1|
	honeypot1.vm.box = "ubuntu/xenial64"
	honeypot1.vm.hostname="honeypot1"
	honeypot1.vm.network "private_network", ip: "192.168.33.11"
	honeypot1.vm.provider "virtualbox" do |vb|
		vb.memory= "4096"
	end
	honeypot1.vm.provision "shell", inline: <<-SHELL	
		apt-get update -y
		apt-get install -y python

		sed -i 's/Port 22/Port 2022/' /etc/ssh/sshd_config

		service ssh restart
	SHELL
  end

  config.vm.define "control" do |control|
	control.vm.box = "ubuntu/xenial64"
	control.vm.network "private_network", ip: "192.168.33.9"
	control.vm.provision "shell", inline: <<-SHELL
		apt-get update -y
		apt-get install -y ansible

		mkdir /etc/ansible/keys
		cp /vagrant/.vagrant/machines/server/virtualbox/private_key /etc/ansible/keys/server
		cp /vagrant/.vagrant/machines/honeypot1/virtualbox/private_key /etc/ansible/keys/honeypot1
		chmod 0600 /etc/ansible/keys/*

	SHELL
  end
  
end
