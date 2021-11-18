cluster = {
  "keycloak" => { 
    :box_image => "generic/ubuntu1804", 
    :ip => "192.168.10.50", 
    :mem => 1024,
    :script => "./keycloak/install.sh",
    :nginx => "./keycloak/nginx",
    :copy => "./keycloak/docker-compose.yml",
    :entrypoint => "docker-compose up -d"
  },
}

Vagrant.configure("2") do |config|
  
  cluster.each do |hostname, info| 

    config.vm.define hostname do |cfg|

      cfg.vm.box = info[:box_image]
      cfg.vm.box_check_update = false
      cfg.vm.network :private_network, ip: info[:ip]

      cfg.vm.provider :virtualbox do |vb, override|
        vb.name = hostname
        vb.memory = info[:mem] if info[:mem]
        vb.cpus = info[:cpus] if info[:cpus]
      end 

      # install nginx
      cfg.vm.provision :file,  source: info[:nginx], destination: "/tmp/nginx"
      cfg.vm.provision :shell, inline: <<-SHELL
        chmod +x /tmp/nginx/install.sh
        cd /tmp/nginx/ && ./install.sh
      SHELL
      
      cfg.vm.provision :shell, path: info[:script] if info[:script]
      cfg.vm.provision :file,  source: info[:copy], destination: "/home/vagrant/" if info[:copy]
      cfg.vm.provision :shell, inline: info[:entrypoint], run: "always" if info[:entrypoint]
      
    end #end config
    end #end loop
  
end #end vagrant