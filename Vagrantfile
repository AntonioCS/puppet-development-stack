
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #http://docs.vagrantup.com/v2/vagrantfile/machine_settings.html
  config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"
  config.vm.box = "ubuntu14_64"
  config.vm.hostname = "acs.dev"
  #http://stackoverflow.com/questions/17845637/vagrant-default-name
  #define a name for the machine (no more default)
  config.vm.define "acs_dev" do |acs_dev|
  end
    
  #http://docs.vagrantup.com/v2/virtualbox/networking.html
  config.vm.network "private_network", ip: "192.168.33.10",
	virtualbox__intnet: true
  
  config.vm.network "forwarded_port", guest: 80, host: 8080
  #RabbitMQ Config page
  config.vm.network "forwarded_port", guest: 15672, host: 15672
  

  #http://docs.vagrantup.com/v2/synced-folders/basic_usage.html
  config.vm.synced_folder "C:/Users/antoniocs/Projects", "/vagrant_data"
  #prevent syncing of the vagrant folder
  #config.vm.synced_folder '.', '/vagrant', disabled: true
  
  config.vm.provider "virtualbox" do |vb|    
    vb.gui = false	   
    vb.memory = 2048	
	#vb.name = "acs_dev"
  end  
  
  # Enable the Puppet provisioner, with will look in manifests
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = "modules"
	
	#http://blog.doismellburning.co.uk/2013/01/19/upgrading-puppet-in-vagrant-boxes/
	#puppet.options = "--hiera_config /etc/hiera.yaml"
  end
  
end
