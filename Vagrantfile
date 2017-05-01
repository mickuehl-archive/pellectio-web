# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# initialize the configuration hash
CONFIG = {}

# Generic box setup (VirtualBox only).
CONFIG['DOMAIN_NAME'] = "rails.local"
CONFIG['NODE_NAME'] = "dev"
CONFIG['MANAGE_HOSTS'] = false

# VirtualBox setup
CONFIG['NODE_MEMORY'] = "2048"
CONFIG['NODE_CPUS'] = 1
CONFIG['NODE_IP'] = "192.168.42.60"

# Setup configuration
CONFIG['PRODUCTION_NODE'] = false

# Computed configuration parameters
HOSTNAME="#{CONFIG['NODE_NAME']}.#{CONFIG['DOMAIN_NAME']}"

# static, internal configurations
NODE_ROOT = "/opt/majordomus"
INSTALL_ROOT = "#{NODE_ROOT}/install"
NODE_DATA = "#{NODE_ROOT}/data"

REPO_URL = "https://github.com/majordomusio/majordomus.ubuntu.git"
REPO_BRANCH = "master"

#
# Start of main section.
#

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # A basic ubuntu box
  config.vm.box = "ubuntu/trusty64"

  # Manage /etc/hosts on both host and guests
  if Vagrant.has_plugin?("vagrant-hostmanager") then
    config.hostmanager.enabled = CONFIG['MANAGE_HOSTS'] # manage guest's /etc/hosts
    config.hostmanager.manage_host = CONFIG['MANAGE_HOSTS'] # manage host's /etc/hosts
  end

  # Update guest additions
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = true
  end

  # VirtualBox setup
  config.vm.provider :virtualbox do |vb|
    vb.memory = CONFIG['NODE_MEMORY']
    vb.cpus = CONFIG['NODE_CPUS']
  end

  # Networking setup
  config.vm.define vm_name = HOSTNAME do |box|
    box.vm.hostname = "#{CONFIG['NODE_NAME']}.#{CONFIG['DOMAIN_NAME']}"
    box.vm.network "private_network", ip: "#{CONFIG['NODE_IP']}"
  end

  # forward the Postgtres port
  # config.vm.network :forwarded_port, guest: 5432, host: 5432

  # Create some folders first
  config.vm.provision "shell", inline: "sudo mkdir -p #{NODE_ROOT}"
  config.vm.provision "shell", inline: "sudo mkdir -p #{NODE_DATA}"

  # Prepare the guest VM and install git
  config.vm.provision "shell", inline: "sudo apt-get -y update --fix-missing"
  config.vm.provision "shell", inline: "sudo apt-get -y install git"
  config.vm.provision "shell", inline: "git config --global user.email 'hello@#{CONFIG['DOMAIN_NAME']}'"
  config.vm.provision "shell", inline: "git config --global user.name 'hello@#{CONFIG['DOMAIN_NAME']}'"

  # Clone the repo into the new VM before stating the setup
  config.vm.provision "shell", inline: "git clone #{REPO_URL} --branch #{REPO_BRANCH} --single-branch #{INSTALL_ROOT}"

  # Add ENVs to /etc/profile
  config.vm.provision "shell", inline: "echo '' >> /etc/profile"
  config.vm.provision "shell", inline: "echo '# majordomus.io settings' >> /etc/profile"
  config.vm.provision "shell", inline: "echo '' >> /etc/profile"
  config.vm.provision "shell", inline: "echo 'export NODE_ROOT=#{NODE_ROOT}' >> /etc/profile"
  config.vm.provision "shell", inline: "echo 'export NODE_DATA=#{NODE_DATA}' >> /etc/profile"
  config.vm.provision "shell", inline: "echo 'export INSTALL_ROOT=#{INSTALL_ROOT}' >> /etc/profile"

  # Prepare for the setup and GO !
  config.vm.provision "shell", inline: "sudo ln -s #{INSTALL_ROOT}/scripts #{NODE_ROOT}/bin"
  config.vm.provision "shell", inline: "sudo #{INSTALL_ROOT}/setup/setup.sh"

  # Install the Docker and add a custom configuration file
  config.vm.provision "docker"
  config.vm.provision "shell", inline: "sudo mkdir -p #{NODE_DATA}/docker/tmp"
  config.vm.provision "shell", inline: "sudo mkdir -p #{NODE_DATA}/docker/images"
  config.vm.provision "shell", inline: "sudo cp #{INSTALL_ROOT}/conf/docker /etc/default/docker"
  config.vm.provision "shell", inline: "sudo service docker restart"

  # Add the default runtime. This is ALWAYS provisioned since we have admin scripts requiring it.
  config.vm.provision "shell", inline: "sudo #{INSTALL_ROOT}/setup/ruby.sh"

  # Mount the project folder to the guest OS for easier development
  config.vm.synced_folder ".", "/home/vagrant/app"

  # Get ownership of all the stuff
  config.vm.provision "shell", inline: "sudo chown -R majord:majord #{NODE_ROOT}"
  config.vm.provision "shell", inline: "sudo chmod -R 775 #{NODE_ROOT}"

  # And finally cleanup ...
  config.vm.provision "shell", inline: "sudo apt-get clean && sudo apt-get -y --purge autoremove"

  # provision the PostgreSQL db
  config.vm.provision "shell", inline: ". /opt/majordomus/bin/postgres.sh pgsql pgsql 5432"
  config.vm.provision "shell", inline: "docker start pgsql"

  # DONE !
end
