# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |main_config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  main_config.vm.box = 'ubuntu_14_04'
  main_config.vm.box_url =
    'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box'

  main_config.vm.define 'db' do |config|
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # config.vm.network 'forwarded_port', guest: 80, host: 8181
    # config.vm.network 'forwarded_port', guest: 9393, host: 9191

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network :private_network, ip: '192.168.30.14'

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    # config.vm.network "public_network"

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    config.ssh.forward_agent = true

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    #
    config.vm.provider 'virtualbox' do |v|
      # Don't boot with headless mode
      # vb.gui = true

      # Use VBoxManage to customize the VM. For example to change memory:
      v.memory = 256
      v.customize ['modifyvm', :id, '--ioapic', 'on']
      host = RbConfig::CONFIG['host_os']
      # Give all cpu cores on the host
      if host =~ /darwin/
        v.cpus = `sysctl -n hw.ncpu`.to_i
      elsif host =~ /linux/
        v.cpus = `nproc`.to_i
      else # sorry Windows folks, I can't help you
        v.cpus = 2
      end
    end

    config.vm.provision 'ansible' do |ansible|
      ansible.playbook = 'ansible/db.yml'
      ansible.verbose = 'vv'
    end
  end

  main_config.vm.define 'app', primary: true do |config|
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # config.vm.network 'forwarded_port', guest: 80, host: 8181
    # config.vm.network 'forwarded_port', guest: 9393, host: 9191

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network :private_network, ip: '192.168.30.15'

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    # config.vm.network "public_network"

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    config.ssh.forward_agent = true

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"
    config.vm.synced_folder '.', '/home/vagrant/project', nfs: true

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    #
    config.vm.provider 'virtualbox' do |v|
      # Don't boot with headless mode
      # vb.gui = true

      # Use VBoxManage to customize the VM. For example to change memory:
      v.memory = 512
      v.customize ['modifyvm', :id, '--ioapic', 'on']
      host = RbConfig::CONFIG['host_os']
      # Give all cpu cores on the host
      if host =~ /darwin/
        v.cpus = `sysctl -n hw.ncpu`.to_i
      elsif host =~ /linux/
        v.cpus = `nproc`.to_i
      else # sorry Windows folks, I can't help you
        v.cpus = 2
      end
    end

    config.vm.provision 'ansible' do |ansible|
      ansible.playbook = 'ansible/app.yml'
      ansible.verbose = 'vv'
    end
  end
end
